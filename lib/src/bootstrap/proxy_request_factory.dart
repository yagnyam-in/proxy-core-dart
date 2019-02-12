import 'package:proxy_core/src/core/proxy_key.dart';

import 'proxy_request.dart';

abstract class ProxyRequestFactory {
  Future<ProxyRequest> createProxyRequest({
    ProxyKey proxyKey,
    String signatureAlgorithm,
    String revocationPassPhrase,
  });
}
