import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';
import 'package:uuid/uuid.dart';

import 'messages/proxy_creation_request.dart';
import 'messages/proxy_creation_response.dart';
import 'proxy_request.dart';

/// Create Proxy
class ProxyFactory with ProxyUtils, HttpClientUtils {
  final Logger _logger = Logger('proxy.bootstrap.ProxyFactory');
  final Uuid uuidFactory = Uuid();

  final String createProxyUrl;
  final HttpClientFactory httpClientFactory;

  ProxyFactory({String createProxyUrl, HttpClientFactory httpClientFactory})
      : createProxyUrl = createProxyUrl ?? "https://proxy-cs.appspot.com/proxy",
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client {
    assert(isNotEmpty(this.createProxyUrl));
    print("ProxyFactory(createProxyUrl: ${this.createProxyUrl})");
  }

  Future<Proxy> createProxy(ProxyRequest proxyRequest) async {
    ProxyCreationRequest request = ProxyCreationRequest(
      requestId: uuidFactory.v4(),
      proxyId: proxyRequest.id,
      revocationPassPhraseSha256: proxyRequest.revocationPassPhraseSha256,
      certificateRequestEncoded: proxyRequest.requestEncoded,
    );
    print("POST $createProxyUrl");
    String jsonResponse = await post(httpClientFactory(), createProxyUrl, jsonEncode(request.toJson()));
    print("POST $createProxyUrl => $jsonResponse");
    ProxyCreationResponse proxyCreationResponse = ProxyCreationResponse.fromJson(jsonDecode(jsonResponse));
    print("POST $createProxyUrl => $proxyCreationResponse");
    return proxyCreationResponse.proxy;
  }
}
