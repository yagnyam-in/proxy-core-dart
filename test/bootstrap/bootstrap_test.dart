import 'package:proxy_core/bootstrap.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/bootstrap/pc_proxy_key_factory.dart';
import 'package:proxy_core/src/bootstrap/pc_proxy_request_factory.dart';
import 'package:proxy_core/src/services/pc_cryptography_service.dart';
import 'package:test/test.dart';

main() {
  PointyCastleCryptographyService cryptographyService = PointyCastleCryptographyService();
  PointyCastleProxyRequestFactory proxyRequestFactory = PointyCastleProxyRequestFactory(cryptographyService);
  PointyCastleProxyKeyFactory proxyKeyFactory = PointyCastleProxyKeyFactory();

  test('Proxy Creation', () async {
    ProxyKey proxyKey = await proxyKeyFactory.createRsaProxyKey(
      id: ProxyIdFactory.instance().testProxyId(),
      keySize: 2048,
    );
    ProxyRequest proxyRequest = await proxyRequestFactory.createProxyRequestForSha256WithRSAEncryption(
      proxyKey: proxyKey,
      revocationPassPhrase: 'hello',
    );
    ProxyFactory proxyFactory = ProxyFactory();
    Proxy proxy = await proxyFactory.createProxy(proxyRequest);
    print(proxy.toJson());
    assert(proxy != null);
    assert(proxy.id.sha256Thumbprint != null);
  });
}
