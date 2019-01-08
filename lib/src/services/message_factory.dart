import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'message_verification_service.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);

typedef SignableMessageFromJson = SignableMessage Function(
    Map<String, dynamic>);

class MessageFactory with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageFactory');

  final MessageVerificationService messageVerificationService;

  MessageFactory({@required this.messageVerificationService}) {
    assert(messageVerificationService != null);
  }

  SignedMessage<T> buildSignedMessage<T extends SignableMessage>(
      String jsonMessage, FromJson<T> signableMessageFactoryMethod) {
    assert(isNotEmpty(jsonMessage));
    assert(signableMessageFactoryMethod != null);
    logger.fine("building from $jsonMessage");
    SignedMessage signedMessageObject =
        SignedMessage.fromJson(jsonDecode(jsonMessage));
    signedMessageObject.message =
        signableMessageFactoryMethod(jsonDecode(signedMessageObject.payload));
    return signedMessageObject;
  }

  Future<bool> verifySignedMessage<T extends SignableMessage>(
      SignedMessage<T> signedMessage) async {
    assert(signedMessage != null);
    // Already verified
    if (signedMessage.verified) {
      logger.fine("$signedMessage is already verified");
      return Future.value(true);
    }
    logger.fine("verifying message $signedMessage");
    assert(signedMessage.message != null,
        "SignedMessage must be built fully before verifying");
    signedMessage.verified =
        await messageVerificationService.verifySignedMessage(signedMessage);
    if (!signedMessage.verified) {
      logger.info("Message verification failed", signedMessage);
      return false;
    }
    List<bool> verificationResults = await Future.wait(
      signedMessage.message
          .getChildMessages()
          .map((s) => verifySignedMessage(s)),
    );
    bool valid = verificationResults.every((v) => v);
    logger.fine(
        "Message verification ${valid ? 'success' : 'failed'} for $signedMessage");
    return valid;
  }

  Future<SignedMessage<T>>
      buildAndVerifySignedMessage<T extends SignableMessage>(
    String jsonMessage,
    FromJson<T> signableMessageFactoryMethod,
  ) async {
    SignedMessage<T> signedMessage =
        buildSignedMessage(jsonMessage, signableMessageFactoryMethod);
    bool valid = await verifySignedMessage(signedMessage);
    if (valid) {
      return signedMessage;
    } else {
      logger.info("Message verification failed", signedMessage);
      throw InvalidMessageException(
          "Message verification failed", signedMessage);
    }
  }
}
