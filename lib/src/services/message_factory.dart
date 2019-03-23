import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/message_builder.dart';

import 'message_verification_service.dart';

class MessageFactory with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageFactory');

  final MessageVerificationService messageVerificationService;

  final MessageBuilder messageBuilder;

  MessageFactory({@required this.messageVerificationService, MessageBuilder messageBuilder})
      : this.messageBuilder = messageBuilder ?? MessageBuilder.instance() {
    assert(this.messageVerificationService != null);
    assert(this.messageBuilder != null);
  }

  SignedMessage<T> buildSignedMessage<T extends SignableMessage>(
    String jsonMessage,
    SignableMessageFromJsonMethod<T> fromJson,
  ) {
    return messageBuilder.buildSignedMessage(jsonMessage, fromJson);
  }

  T buildSignableMessage<T extends SignableMessage>(
    String jsonMessage,
    SignableMessageFromJsonMethod<T> fromJson,
  ) {
    return messageBuilder.buildSignableMessage(jsonMessage, fromJson);
  }

  Future<bool> verifySignedMessage<T extends SignableMessage>(
    SignedMessage<T> signedMessage,
  ) async {
    assert(signedMessage != null);
    // Already verified
    if (signedMessage.verified) {
      logger.fine("$signedMessage is already verified");
      return Future.value(true);
    }
    logger.fine("verifying message $signedMessage");
    assert(signedMessage.message != null, "SignedMessage must be built fully before verifying");
    signedMessage.verified = await messageVerificationService.verifySignedMessage(signedMessage);
    if (!signedMessage.verified) {
      logger.info("Message verification failed", signedMessage);
      return false;
    }
    List<bool> verificationResults = await Future.wait(
      signedMessage.message.getChildMessages().map((s) => verifySignedMessage(s)),
    );
    bool valid = verificationResults.every((v) => v);
    logger.fine("Message verification ${valid ? 'success' : 'failed'} for $signedMessage");
    return valid;
  }

  Future<SignedMessage<T>> buildAndVerifySignedMessage<T extends SignableMessage>(
    String jsonMessage,
    SignableMessageFromJsonMethod<T> buildMethod,
  ) async {
    SignedMessage<T> signedMessage = buildSignedMessage(jsonMessage, buildMethod);
    bool valid = await verifySignedMessage(signedMessage);
    if (valid) {
      return signedMessage;
    } else {
      logger.info("Message verification failed", signedMessage);
      throw InvalidMessageException("Message verification failed", signedMessage);
    }
  }
}
