import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/hash_value.dart';
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
      signatureAlgorithms: {signatureAlgorithm},
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

  Future<HashValue> getHash({
    @required String hashAlgorithm,
    @required String input,
  }) {
    if (hashAlgorithm.toUpperCase() == 'SHA256' || hashAlgorithm.toUpperCase() == 'SHA-256') {
      return getSha256Hash(input: input, hashAlgorithm: hashAlgorithm);
    } else {
      throw ArgumentError("Invalid Hash Algorithm $hashAlgorithm");
    }
  }

  Future<bool> verifyHash({
    @required HashValue hashValue,
    @required String input,
  }) {
    if (hashValue.algorithm.toUpperCase() == 'SHA256' || hashValue.algorithm.toUpperCase() == 'SHA-256') {
      return verifySha256Hash(input: input, hashValue: hashValue);
    } else {
      throw ArgumentError("Invalid Hash Algorithm ${hashValue.algorithm}");
    }
  }

  Future<HashValue> getSha256Hash({
    @required String hashAlgorithm,
    @required String input,
  }) async {
    var iv = randomIv();
    var digest = sha256.convert(iv + utf8.encode(input));
    return HashValue(iv: base64Encode(iv), hash: base64Encode(digest.bytes), algorithm: hashAlgorithm,);
  }


  Future<bool> verifySha256Hash({
    @required HashValue hashValue,
    @required String input,
  }) async {
    Uint8List iv = base64Decode(hashValue.iv);
    var digest = sha256.convert(iv + utf8.encode(input));
    return listEquals(digest.bytes, base64Decode(hashValue.hash));
  }


  static List<int> randomIv([int length = 32]) {
    var rand = Random.secure();
    return new List.generate(
      length,
      (index) => rand.nextInt(256),
    );
  }
}
