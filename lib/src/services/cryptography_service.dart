import 'dart:async';

import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

/// Cryptography Service to sign, verify, encrypt and decrypt messages
///
/// This is abstraction over Cryptographic implementation and representation of Proxy
///
abstract class CryptographyService with ProxyUtils {
  /// Get the digital signature of given Signature Algorithm
  Future<String> getSignature({
    @required ProxyKey proxyKey,
    @required String input,
    @required String signatureAlgorithm,
  }) async {
    Map<String, String> signatures = await getSignatures(
      proxyKey: proxyKey,
      input: input,
      signatureAlgorithms: Set.of([signatureAlgorithm]),
    );
    String signature = signatures[signatureAlgorithm];
    assert(isNotEmpty(signature));
    return signature;
  }

  /// Get the digital signatures of given Signature Algorithms at once
  Future<Map<String, String>> getSignatures({
    @required ProxyKey proxyKey,
    @required String input,
    @required Set<String> signatureAlgorithms,
  });

  /// Verify the digital signature
  Future<bool> verifySignature({
    @required Proxy proxy,
    @required String input,
    @required String signatureAlgorithm,
    @required String signature,
  }) {
    return verifySignatures(
      proxy: proxy,
      input: input,
      signatures: {
        signatureAlgorithm: signature,
      },
    );
  }

  /// Verify multiple digital signatures at once
  Future<bool> verifySignatures({
    @required Proxy proxy,
    @required String input,
    @required Map<String, String> signatures,
  });

  Future<String> encrypt({
    @required Proxy proxy,
    @required String encryptionAlgorithm,
    @required String input,
  });

  Future<String> decrypt({
    @required ProxyKey proxyKey,
    @required String encryptionAlgorithm,
    @required String cipherText,
  });

  // Get the Cryptographic Hash of given message
  Future<String> getHash({
    @required String hashAlgorithm,
    @required String input,
  });
}
