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
    List<bool> verificationResults = await Future.wait([
      messageVerificationService.verifySignedMessage(signedMessage),
      ...signedMessage.message.getSignedChildMessages().map((s) => verifySignedMessage(s)).toList(),
      ...signedMessage.message.getMultiSignedChildMessages().map((s) => verifyMultiSignedMessage(s)).toList(),
    ]);
    signedMessage.verified = verificationResults.every((v) => v);
    logger.fine("Message verification ${signedMessage.verified ? 'success' : 'failed'} for $signedMessage");
    return signedMessage.verified;
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

  // Multi Signed Messages

  MultiSignedMessage<T> buildMultiSignedMessage<T extends MultiSignableMessage>(
      String jsonMessage,
      MultiSignableMessageFromJsonMethod<T> fromJson,
      ) {
    return messageBuilder.buildMultiSignedMessage(jsonMessage, fromJson);
  }

  T buildMultiSignableMessage<T extends MultiSignableMessage>(
      String jsonMessage,
      MultiSignableMessageFromJsonMethod<T> fromJson,
      ) {
    return messageBuilder.buildMultiSignableMessage(jsonMessage, fromJson);
  }

  Future<bool> verifyMultiSignedMessage<T extends MultiSignableMessage>(
      MultiSignedMessage<T> signedMessage,
      ) async {
    assert(signedMessage != null);
    // Already verified
    if (signedMessage.verified) {
      logger.fine("$signedMessage is already verified");
      return Future.value(true);
    }
    logger.fine("verifying message $signedMessage");
    assert(signedMessage.message != null, "MultiSignedMessage must be built fully before verifying");
    List<bool> verificationResults = await Future.wait([
      messageVerificationService.verifyMultiSignedMessage(signedMessage),
      ...signedMessage.message.getSignedChildMessages().map((s) => verifySignedMessage(s)).toList(),
      ...signedMessage.message.getMultiSignedChildMessages().map((s) => verifyMultiSignedMessage(s)).toList(),
    ]);
    signedMessage.verified = verificationResults.every((v) => v);
    logger.fine("Message verification ${signedMessage.verified ? 'success' : 'failed'} for $signedMessage");
    return signedMessage.verified;
  }

  Future<MultiSignedMessage<T>> buildAndVerifyMultiSignedMessage<T extends MultiSignableMessage>(
      String jsonMessage,
      MultiSignableMessageFromJsonMethod<T> buildMethod,
      ) async {
    MultiSignedMessage<T> signedMessage = buildMultiSignedMessage(jsonMessage, buildMethod);
    bool valid = await verifyMultiSignedMessage(signedMessage);
    if (valid) {
      return signedMessage;
    } else {
      logger.info("Message verification failed", signedMessage);
      throw InvalidMessageException("Message verification failed", signedMessage);
    }
  }

}
