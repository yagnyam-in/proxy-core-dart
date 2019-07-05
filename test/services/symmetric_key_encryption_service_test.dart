import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/services/symmetric_key_encryption_service.dart';
import "package:test/test.dart";

main() {
  test('SymmetricKeyEncryptionService Encrypt/Decrypt', () async {
    var encryptionService = SymmetricKeyEncryptionService();
    String input = "Hello World!!";
    String key = "MyKey";
    CipherText cipherText = await encryptionService.encrypt(
      encryptionAlgorithm: SymmetricKeyEncryptionService.ENCRYPTION_ALGORITHM,
      plainText: input,
      key: key,
    );
    expect(cipherText.encryptionAlgorithm, SymmetricKeyEncryptionService.ENCRYPTION_ALGORITHM);
    expect(cipherText.hmacAlgorithm, isNull);
    expect(cipherText.hmac, isNull);
    expect(await encryptionService.decrypt(cipherText: cipherText, key: key), input);
    expect(() async => await encryptionService.decrypt(key: 'dummy', cipherText: cipherText), throwsArgumentError);
  });

  test('SymmetricKeyEncryptionService Encrypt/Decrypt with HMAC', () async {
    var encryptionService = SymmetricKeyEncryptionService();
    String input = "Hello World!!";
    String key = "MyKey";
    CipherText cipherText = await encryptionService.encrypt(
      encryptionAlgorithm: SymmetricKeyEncryptionService.ENCRYPTION_ALGORITHM,
      plainText: input,
      key: key,
      hmacAlgorithm: SymmetricKeyEncryptionService.HMAC_ALGORITHM,
    );
    expect(cipherText.encryptionAlgorithm, SymmetricKeyEncryptionService.ENCRYPTION_ALGORITHM);
    expect(cipherText.hmacAlgorithm, SymmetricKeyEncryptionService.HMAC_ALGORITHM);
    expect(cipherText.hmac, isNotNull);
    expect(await encryptionService.decrypt(cipherText: cipherText, key: key), input);
    expect(() async => await encryptionService.decrypt(key: 'dummy', cipherText: cipherText), throwsArgumentError);
    expect(
        () async => await encryptionService.decrypt(
            key: key,
            cipherText: CipherText(
              iv: cipherText.iv,
              cipherText: cipherText.cipherText,
              encryptionAlgorithm: cipherText.encryptionAlgorithm,
              hmacAlgorithm: cipherText.hmacAlgorithm,
              hmac: 'dummy',
            )),
        throwsArgumentError);
  });
}
