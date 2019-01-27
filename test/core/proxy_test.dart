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
          certificateEncoded: "certificate"),
    );
    expect(proxy.id, ProxyId("id", "sha256"));
  });
}
