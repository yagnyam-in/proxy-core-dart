import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

typedef SignableMessageFromJsonMethod<T extends SignableMessage> = T Function(Map<String, dynamic>);

typedef SignedMessageFromJsonMethod<T extends SignableMessage> = SignedMessage<T> Function(Map<String, dynamic>);

class MessageBuilder with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageBuilder');

  MessageBuilder();

  factory MessageBuilder.instance() => MessageBuilder();

  SignedMessage<T> buildSignedMessage<T extends SignableMessage>(
    String jsonMessage,
    SignableMessageFromJsonMethod<T> fromJson,
  ) {
    assert(isNotEmpty(jsonMessage));
    assert(fromJson != null);
    logger.fine("building SignedMessage from $jsonMessage");
    SignedMessage<T> signedMessage = SignedMessage.fromJson<T>(jsonDecode(jsonMessage));
    signedMessage.message = fromJson(jsonDecode(signedMessage.payload));
    return signedMessage;
  }

  T buildSignableMessage<T extends SignableMessage>(
    String jsonMessage,
    SignableMessageFromJsonMethod<T> fromJson,
  ) {
    assert(isNotEmpty(jsonMessage));
    assert(fromJson != null);
    logger.fine("building SignableMessage from $jsonMessage");
    return fromJson(jsonDecode(jsonMessage));
  }
}
