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
    assert(this.proxyVersion.validSignatureAlgorithmSets.isNotEmpty);
    assert(this.proxyVersion.validSignatureAlgorithmSets.every((s) => s.isNotEmpty));
    assert(this.proxyVersion.preferredSignatureAlgorithmSet.isNotEmpty);
  }

  Future<bool> verifySignedMessage<T extends SignableMessage>(SignedMessage<T> message) async {
    assert(message != null);
    if (message.message == null) {
      logger.shout("SignedMessage must be de-serialized before verifying signature");
      throw StateError("SignedMessage must be de-serialized before verifying signature");
    }
    if (!message.isValid()) {
      logger.info("Message validation failed $message");
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
    Set<String> signatureAlgorithmSet = message.signatures.map((s) => s.algorithm).toSet();
    if (!proxyVersion.validSignatureAlgorithmSets
        .any((set) => set.length == signatureAlgorithmSet.length && set.every(signatureAlgorithmSet.contains))) {
      logger.info("Un-recognised signature algorithms $signatureAlgorithmSet in $message");
      print(
          "Un-recognised signature algorithms $signatureAlgorithmSet. Valid => ${proxyVersion.validSignatureAlgorithmSets}");
      throw InvalidMessageException("Un-recognised signature algorithms $signatureAlgorithmSet", message);
    }
    Proxy proxy = await _getSignerProxy(message.signedBy);
    Map<String, String> signatures = Map.fromEntries(message.signatures.map((s) => MapEntry(s.algorithm, s.value)));
    bool valid = await cryptographyService.verifySignatures(
      proxy: proxy,
      input: message.payload,
      signatures: signatures,
    );
    logger.fine("Message verification ${valid ? 'success' : 'failed'} for $message");
    return valid;
  }

  Future<bool> verifyMultiSignedMessage<T extends MultiSignableMessage>(MultiSignedMessage<T> message) async {
    assert(message != null);
    if (message.message == null) {
      logger.shout("SignedMessage must be de-serialized before verifying signature");
      throw StateError("SignedMessage must be de-serialized before verifying signature");
    }
    if (!message.isValid()) {
      logger.info("Message validation failed $message");
      throw InvalidMessageException("Message validation failed", message);
    }
    final verificationResults =
        await Future.wait(message.signatures.map((signature) => _verifyMultiSignature(message, signature)).toList());
    return verificationResults.every((e) => e);
  }

  Future<bool> _verifyMultiSignature<T extends MultiSignableMessage>(
      MultiSignedMessage<T> message, MultiSignedMessageSignature signature) async {
    if (!message.cabBeSignedBy(signature.signedBy)) {
      logger.info(
          "Message can only be signed by ${message.validSigners()}, but signed by ${signature.signedBy}", message);
      throw InvalidMessageException(
          "Message can only be signed by ${message.validSigners()}, but signed by ${signature.signedBy}", message);
    }
    Set<String> signatureAlgorithmSet = signature.signatures.map((s) => s.algorithm).toSet();
    if (!proxyVersion.validSignatureAlgorithmSets
        .any((set) => set.length == signatureAlgorithmSet.length && set.every(signatureAlgorithmSet.contains))) {
      logger.info("Un-recognised signature algorithms $signatureAlgorithmSet in $message");
      print(
          "Un-recognised signature algorithms $signatureAlgorithmSet. Valid => ${proxyVersion.validSignatureAlgorithmSets}");
      throw InvalidMessageException("Un-recognised signature algorithms $signatureAlgorithmSet", message);
    }
    Proxy proxy = await _getSignerProxy(signature.signedBy);
    Map<String, String> signatures = Map.fromEntries(signature.signatures.map((s) => MapEntry(s.algorithm, s.value)));
    bool valid = await cryptographyService.verifySignatures(
      proxy: proxy,
      input: message.payload,
      signatures: signatures,
    );
    logger.fine("Message verification ${valid ? 'success' : 'failed'} for $message");
    return valid;
  }

  /// Get the Signer Proxy
  Future<Proxy> _getSignerProxy(ProxyId signer) async {
    Proxy proxy = await proxyResolver.resolveProxy(signer);
    if (proxy == null) {
      logger.info("Invalid Signer/Proxy Id. No proxy found.");
      throw ArgumentError("Invalid Signer/Proxy Id. No proxy found.");
    }
    return proxy;
  }
}
