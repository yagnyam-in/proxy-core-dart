import 'package:proxy_core/core.dart';
import "package:test/test.dart";

main() {
  test('Proxy.fromCertificate', () {
    Proxy proxy = Proxy.fromCertificate(
      Certificate(
        serialNumber: "123",
        owner: "id",
        sha256Thumbprint: "sha256",
        subject: "cn: id",
        validFrom: DateTime.now(),
        validTill: DateTime.now(),
        certificateEncoded: "certificate",
        publicKeyEncoded: 'publicKey',
        publicKeySha256Thumbprint: 'publicKeySha256',
      ),
    );
    expect(proxy.id, ProxyId("id", "sha256"));
    expect(proxy.publicKeyEncoded, 'publicKey');
    expect(proxy.publicKeySha256Thumbprint, 'publicKeySha256');
  });
}
