import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'cryptography_service.dart';
import 'proxy_resolver.dart';

/// Message Verification service for validating signatures on the message
///
/// Note: This service only verifies the requested object (not recursive). To validate child objects also use `MessageFactory`
class MessageVerificationService with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageVerificationService');

  final CryptographyService cryptographyService;

  final ProxyResolver proxyResolver;

  final ProxyVersion proxyVersion;

  MessageVerificationService({
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

  Future<bool> verifySignedMessage<T extends SignableMessage>(SignedMessage<T> message) async {
    assert(message != null);
    if (!message.isValid()) {
      logger.info("Message validation failed", message);
      throw InvalidMessageException("Message validation failed", message);
    }
    if (!message.cabBeSignedBy(message.signedBy)) {
      logger.info(
          "Message can only be signed by ${message.validSigners()}, but signed by ${message.signedBy}", message);
      throw InvalidMessageException(
          "Message can only be signed by ${message.validSigners()}, but signed by ${message.signedBy}", message);
    }
    if (message.signatures.isEmpty) {
      logger.info("No signatures found in $message");
      throw InvalidMessageException("No signatures found", message);
    }
    Set<String> signatureAlgorithmSet = message.signatures.map((s) => s.algorithm);
    if (!proxyVersion.validSignatureAlgorithmSets.contains(signatureAlgorithmSet)) {
      logger.info("Un-recognised signature algorithms $signatureAlgorithmSet in $message");
      throw InvalidMessageException("Un-recognised signature algorithms $signatureAlgorithmSet", message);
    }
    Proxy proxy = await getSignerProxy(message);
    Map<String, String> signatures = Map.fromEntries(message.signatures.map((s) => MapEntry(s.algorithm, s.value)));
    bool valid = await cryptographyService.verifySignatures(
      proxy: proxy,
      input: message.payload,
      signatures: signatures,
    );
    logger.fine("Message verification ${valid ? 'success' : 'failed'} for $message");
    return valid;
  }

  /// Get the Signer Proxy
  Future<Proxy> getSignerProxy(SignedMessage message) async {
    if (message.message == null) {
      logger.shout("SignedMessage must be de-serialized before verifying signature");
      throw StateError("SignedMessage must be de-serialized before verifying signature");
    }
    List<Proxy> proxies = await proxyResolver.resolveProxy(message.signedBy);
    if (proxies.isEmpty) {
      logger.info("Invalid Signer/Proxy Id. No proxies found.");
      throw ArgumentError("Invalid Signer/Proxy Id. No proxies found.");
    } else if (proxies.length != 1) {
      logger.info("Incomplete Signer/Proxy Id. Multiple proxies found.");
      throw ArgumentError("Incomplete Signer/Proxy Id. Multiple proxies found.");
    } else {
      return proxies[0];
    }
  }
}
