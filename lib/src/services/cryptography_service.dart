import 'package:proxy_core/core.dart';

/// Cryptography Service to sign, verify, encrypt and decrypt messages
///
/// This is abstraction over Cryptographic implementation and representation of Proxy
///
abstract class CryptographyService with ProxyUtils {
  /// Get the digital signature of given Signature Algorithm
  Future<String> getSignature({
    Proxy proxy,
    String input,
    String signatureAlgorithm,
  }) async {
    Map<String, String> signatures = await getSignatures(
      proxy: proxy,
      input: input,
      signatureAlgorithms: Set.of([signatureAlgorithm]),
    );
    String signature = signatures[signatureAlgorithm];
    assert(isNotEmpty(signature));
    return signature;
  }

  /// Get the digital signatures of given Signature Algorithms at once
  Future<Map<String, String>> getSignatures({
    Proxy proxy,
    String input,
    Set<String> signatureAlgorithms,
  });

  /// Verify the digital signature
  Future<bool> verifySignature({
    Proxy proxy,
    String input,
    String signatureAlgorithm,
    String signature,
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
    Proxy proxy,
    String input,
    Map<String, String> signatures,
  });

  Future<String> encrypt({
    Proxy proxy,
    String encryptionAlgorithm,
    String input,
  });

  Future<String> decrypt({
    Proxy proxy,
    String encryptionAlgorithm,
    String cipherText,
  });
}
