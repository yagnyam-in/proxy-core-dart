import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'proxy_resolver.dart';
import 'proxy_http_client.dart';

typedef ProxyFetchUrl = String Function(String id,
    [String sha256Thumbprint]);

typedef HttpClientFactory = http.Client Function();

class RemoteProxyResolver
    with ProxyUtils, HttpClientUtils
    implements ProxyResolver {
  final Logger logger = Logger('proxy.services.RemoteCertificateService');

  final ProxyFetchUrl proxyFetchUrl;

  final HttpClientFactory httpClientFactory;

  RemoteProxyResolver({
    @required this.proxyFetchUrl,
    HttpClientFactory httpClientFactory,
  })  : assert(proxyFetchUrl != null),
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client;

  @override
  Future<Proxy> resolveProxy(ProxyId proxyId) async {
    assert(proxyId != null);
    String response = await get(
        httpClientFactory(), proxyFetchUrl(proxyId.id, proxyId.sha256Thumbprint));
    return Proxy.fromJson(jsonDecode(response));
  }
}
