import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';

class SymmetricKeyEncryptionService {
  static const String ENCRYPTION_ALGORITHM = 'AES/CTR/NoPadding';
  static const String HMAC_ALGORITHM = 'HMACSHA256';

  Future<CipherText> encrypt({
    @required String key,
    @required String encryptionAlgorithm,
    @required String plainText,
    String hmacAlgorithm,
  }) async {
    final encryptionKey = _adjustedKey(key);
    final IV iv = IV(Uint8List.fromList(CryptographyService.randomIv(encryptionKey.bytes.length)));
    Encrypter encrypter = _cipher(
      encryptionAlgorithm: encryptionAlgorithm,
      key: encryptionKey,
    );
    String cipherText = encrypter.encrypt(plainText, iv: iv).base64;
    String hmac;
    if (hmacAlgorithm != null) {
      hmac = await _getHmac(
        hmacAlgorithm: hmacAlgorithm,
        key: encryptionKey,
        input: iv.bytes + utf8.encode(plainText),
      );
    }
    return CipherText(
      encryptionAlgorithm: encryptionAlgorithm,
      iv: iv.base64,
      cipherText: cipherText,
      hmacAlgorithm: hmacAlgorithm,
      hmac: hmac,
    );
  }

  Future<String> decrypt({
    @required String key,
    @required CipherText cipherText,
  }) async {
    final encryptionKey = _adjustedKey(key);
    final IV iv = IV.fromBase64(cipherText.iv);
    Encrypter encrypter = _cipher(
      encryptionAlgorithm: cipherText.encryptionAlgorithm,
      key: encryptionKey,
    );
    String plainText = encrypter.decrypt64(cipherText.cipherText, iv: iv);
    if (cipherText.hmacAlgorithm != null) {
      final hmac = await _getHmac(
        hmacAlgorithm: cipherText.hmacAlgorithm,
        key: encryptionKey,
        input: iv.bytes + utf8.encode(plainText),
      );
      if (hmac != cipherText.hmac) {
        throw ArgumentError("HMAC doesn't match");
      }
    }
    return plainText;
  }

  Future<String> _getHmac({
    @required String hmacAlgorithm,
    @required Key key,
    @required List<int> input,
  }) {
    if (hmacAlgorithm.toUpperCase() == 'HMACSHA256' || hmacAlgorithm.toUpperCase() == 'HMACSHA-256') {
      return _getSha256Hmac(key: key, input: input);
    } else {
      throw ArgumentError("Invalid HMAC Algorithm $hmacAlgorithm");
    }
  }

  Future<String> _getSha256Hmac({
    @required Key key,
    @required List<int> input,
  }) async {
    var hmacSha256 = new Hmac(sha256, key.bytes);
    var digest = hmacSha256.convert(input);
    return base64Encode(digest.bytes);
  }

  // TODO: Revisit
  Key _adjustedKey(String key) {
    String adjusted = key;
    Key adjustedKey = Key.fromUtf8(adjusted);
    int len = adjustedKey.bytes.lengthInBytes;
    if ({16, 24, 32}.contains(len)) {
      return adjustedKey;
    } else if (len < 16) {
      adjusted = adjusted.padRight(16, '0');
    } else if (len < 24) {
      adjusted = adjusted.padRight(24, '0');
    } else if (len < 32) {
      adjusted = adjusted.padRight(32, '0');
    } else {
      throw ArgumentError("Invalid length $len for pass phrase");
    }
    return Key.fromUtf8(adjusted);
  }

  // TODO: Revisit
  Encrypter _cipher({
    @required String encryptionAlgorithm,
    @required Key key,
  }) {
    if (encryptionAlgorithm.toUpperCase() == ENCRYPTION_ALGORITHM.toUpperCase()) {
      return Encrypter(AES(key, mode: AESMode.ctr));
    }
    throw ArgumentError("Invalid encryptionAlgorithm $encryptionAlgorithm");
  }
}
