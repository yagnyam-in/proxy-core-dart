import 'package:proxy_core/src/services/rsa_service.dart';
import 'package:test/test.dart';

main() {
  RsaService rsaService = RsaService();

  test('Sign and Verify', () async {
    var keyPair = await rsaService.generateRsaKeyPair(2048);
    var message = 'Hello World!!!';
    var signature = await rsaService.sign(
      message: message,
      algorithm: 'SHA256WithRSAEncryption',
      privateKey: keyPair.privateKey,
    );
    expect(
        await rsaService.verify(
          algorithm: 'SHA256WithRSAEncryption',
          signedMessage: signature,
          message: message,
          publicKey: keyPair.publicKey,
        ),
        true);
    expect(
        await rsaService.verify(
          algorithm: 'SHA256WithRSAEncryption',
          signedMessage: signature,
          message: message + '.',
          publicKey: keyPair.publicKey,
        ),
        false);
  });
}
