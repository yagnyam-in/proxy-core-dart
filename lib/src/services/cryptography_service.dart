import 'package:proxy_core/core.dart';

abstract class CryptographyService {
  Future<String> getSignature({
    Proxy proxy,
    String signatureAlgorithm,
    String input,
  });

  Future<bool> verifySignature({
    Certificate certificate,
    String signatureAlgorithm,
    String input,
    String signature,
  });

  Future<String> encrypt({
    Certificate certificate,
    String encryptionAlgorithm,
    String input,
  });

  Future<String> decrypt({
    Proxy proxy,
    String encryptionAlgorithm,
    String cipherText,
  });
}
