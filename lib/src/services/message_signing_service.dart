import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

import 'cryptography_service.dart';

/// Message Signing service for digitally signing messages by multiple parties
///
/// Note: One party must sign the message first and then send it to others for Signing.
/// `MessageFactory` is counterpart of this class to verify message
class MessageSigningService with ProxyUtils {
  final Logger logger = Logger('proxy.services.MessageSigningService');

  final CryptographyService cryptographyService;

  final ProxyVersion proxyVersion;

  MessageSigningService({
    @required this.cryptographyService,
    ProxyVersion proxyVersion,
  }) : proxyVersion = proxyVersion ?? ProxyVersion.latestVersion() {
    assert(cryptographyService != null);
    assert(this.proxyVersion.validSignatureAlgorithmSets.isNotEmpty);
    assert(this.proxyVersion.validSignatureAlgorithmSets.every((s) => s.isNotEmpty));
    assert(this.proxyVersion.preferredSignatureAlgorithmSet.isNotEmpty);
  }

  Future<SignedMessage<T>> sign<T extends SignableMessage>(T message, ProxyKey signer) async {
    assert(message != null);
    if (!message.isValid()) {
      logger.info("Message validation failed", message);
      throw InvalidMessageException("Message validation failed", message);
    }
    if (!message.cabBeSignedBy(signer.id)) {
      logger.info(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${signer.id}", message);
      throw InvalidMessageException(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${signer.id}", message);
    }
    String payload = jsonEncode(message.toJson());
    Set<String> signatureAlgorithmSet = proxyVersion.preferredSignatureAlgorithmSet;
    if (signatureAlgorithmSet.isEmpty) {
      logger.shout("At least one signature algorithm is mandatory, but found none");
      throw new StateError("At least one signature algorithm is mandatory, but found none");
    }
    Map<String, String> signatures = await cryptographyService.getSignatures(
      proxyKey: signer,
      input: payload,
      signatureAlgorithms: signatureAlgorithmSet,
    );
    logger.info("Singatures for $message => $signatures");
    return SignedMessage(
      message: message,
      type: message.messageType,
      payload: payload,
      signedBy: signer.id,
      signatures: signatures.entries.map((e) => SignedMessageSignature(e.key, e.value)).toList(),
    );
  }

  Future<MultiSignedMessage<T>> addSignature<T extends MultiSignableMessage>(
    MultiSignedMessage<T> signedMessage,
    ProxyKey signer,
  ) async {
    assert(signedMessage != null);
    MultiSignableMessage message = signedMessage.message;
    assert(message != null);
    if (!message.isValid()) {
      logger.info("Message validation failed", message);
      throw InvalidMessageException("Message validation failed", message);
    }
    if (!message.cabBeSignedBy(signer.id)) {
      logger.info(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${signer.id}", message);
      throw InvalidMessageException(
          "Message can only be signed by ${message.getValidSigners()}, but trying to sign by ${signer.id}", message);
    }
    String payload = signedMessage.payload;
    Set<String> signatureAlgorithmSet = proxyVersion.preferredSignatureAlgorithmSet;
    if (signatureAlgorithmSet.isEmpty) {
      logger.shout("At least one signature algorithm is mandatory, but found none");
      throw new StateError("At least one signature algorithm is mandatory, but found none");
    }
    Map<String, String> signatures = await cryptographyService.getSignatures(
      proxyKey: signer,
      input: payload,
      signatureAlgorithms: signatureAlgorithmSet,
    );
    final MultiSignedMessageSignature multiSignature = MultiSignedMessageSignature(
      signedBy: signer.id,
      signatures: signatures.entries.map((e) => SignedMessageSignature(e.key, e.value)).toList(),
    );
    logger.info("Singature for $message => $multiSignature");
    return signedMessage.addSignature(multiSignature);
  }

  Future<MultiSignedMessage<T>> multiSign<T extends MultiSignableMessage>(
    T message,
    ProxyKey signer,
  ) async {
    String payload = jsonEncode(message.toJson());
    MultiSignedMessage multiSignedMessage = MultiSignedMessage(
      message: message,
      type: message.messageType,
      payload: payload,
      signatures: [],
    );
    return addSignature(multiSignedMessage, signer);
  }
}
