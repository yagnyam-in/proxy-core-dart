import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'cryptography_service.dart';
import 'proxy_resolver.dart';
import 'dart:convert';

/// Message Signing service for digitally signing messages
///
/// `MessageFactory` is counterpart of this class to verify message
class MessageSigningService with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageSigningService');

  final CryptographyService cryptographyService;

  final ProxyResolver proxyResolver;

  final ProxyVersion proxyVersion;

  MessageSigningService({
    @required this.cryptographyService,
    @required this.proxyResolver,
    ProxyVersion proxyVersion,
  }) : proxyVersion = proxyVersion ?? ProxyVersion.latestVersion() {
    assert(cryptographyService != null);
    assert(proxyResolver != null);
    assert(proxyVersion.validSignatureAlgorithmSets.isNotEmpty);
    assert(proxyVersion.validSignatureAlgorithmSets.every((s) => s.isNotEmpty));
    assert(proxyVersion.preferredSignatureAlgorithmSet.isNotEmpty);
  }

  Future<SignedMessage<T>> signMessage<T extends SignableMessage>(T message, Proxy proxy) async {
    assert(message != null);
    if (!message.isValid()) {
      logger.info("Message validation failed", message);
      throw InvalidMessageException("Message validation failed", message);
    }
    if (!message.cabBeSignedBy(proxy.id)) {
      logger.info(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${proxy.id}", message);
      throw InvalidMessageException(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${proxy.id}", message);
    }
    String payload = jsonEncode(message.toJson());
    Set<String> signatureAlgorithmSet = proxyVersion.preferredSignatureAlgorithmSet;
    if (signatureAlgorithmSet.isEmpty) {
      logger.shout("At least one signature algorithm is mandatory, but found none");
      throw new StateError("At least one signature algorithm is mandatory, but found none");
    }
    Map<String, String> signatures = await cryptographyService.getSignatures(
      proxy: proxy,
      input: payload,
      signatureAlgorithms: signatureAlgorithmSet,
    );
    logger.fine("Singatures for $message => $signatures");
    return SignedMessage(
      type: message.messageType,
      payload: payload,
      signedBy: proxy.id,
      signatures: signatures.entries.map((e) => SignedMessageSignature(e.key, e.value)),
    );
  }
}
