import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

typedef SignableMessageBuildMethod<T extends SignableMessage> = T Function(
    Map<String, dynamic>, MessageBuilder buildr);

typedef SignedMessageBuildMethod<T extends SignableMessage> = SignedMessage<T> Function(
    Map<String, dynamic>, MessageBuilder buildr);

class MessageBuilder with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageBuilder');

  SignedMessage<T> buildSignedMessage<T extends SignableMessage>(
    String jsonMessage,
      SignableMessageBuildMethod<T> buildMethod,
  ) {
    assert(isNotEmpty(jsonMessage));
    assert(buildMethod != null);
    logger.fine("building SignedMessage from $jsonMessage");
    SignedMessage<T> signedMessage = SignedMessage.fromJson<T>(jsonDecode(jsonMessage));
    signedMessage.message = buildMethod(jsonDecode(signedMessage.payload), this);
    return signedMessage;
  }

  T buildSignableMessage<T extends SignableMessage>(
    String jsonMessage,
      SignableMessageBuildMethod<T> buildMethod,
  ) {
    assert(isNotEmpty(jsonMessage));
    assert(buildMethod != null);
    logger.fine("building SignableMessage from $jsonMessage");
    return buildMethod(jsonDecode(jsonMessage), this);
  }
}
