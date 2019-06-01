import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:proxy_core/core.dart';

import 'proxy_http_client.dart';
import 'proxy_resolver.dart';

typedef HttpClientFactory = http.Client Function();

class RemoteProxyResolver with ProxyUtils, HttpClientUtils implements ProxyResolver {
  final Logger _logger = Logger('proxy.services.RemoteCertificateService');

  final String proxyFetchUrl;
  final HttpClientFactory httpClientFactory;

  RemoteProxyResolver({
    String proxyFetchUrl,
    HttpClientFactory httpClientFactory,
  })  : proxyFetchUrl = proxyFetchUrl ?? "https://cs.pxy.yagnyam.in/proxy",
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client {
    _logger.info("constructing RemoteProxyResolver(proxyFetchUrl: $proxyFetchUrl)");
  }

  @override
  Future<Proxy> resolveProxy(ProxyId proxyId) async {
    assert(proxyId != null);
    String url = _getProxyFetchUrl(proxyId.id, proxyId.sha256Thumbprint);
    _logger.fine("resolveProxy($proxyId) => $url");
    String response = await get(httpClientFactory(), url);
    return Proxy.fromJson(jsonDecode(response));
  }

  String _getProxyFetchUrl(String id, String sha256Thumbprint) {
    String urlPrefix = proxyFetchUrl.endsWith('/') ? proxyFetchUrl : '$proxyFetchUrl/';
    return "$urlPrefix$id?sha256Thumbprint=$sha256Thumbprint";
  }
}
