import 'dart:async';
import 'dart:convert';

import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';
import 'package:uuid/uuid.dart';

import 'messages/proxy_creation_request.dart';
import 'messages/proxy_creation_response.dart';
import 'proxy_request.dart';

/// Create Proxy
class ProxyFactory with ProxyUtils, HttpClientUtils, DebugUtils {
  final Uuid uuidFactory = Uuid();

  final String createProxyUrl;
  final HttpClientFactory httpClientFactory;

  ProxyFactory({String createProxyUrl, HttpClientFactory httpClientFactory})
      : createProxyUrl = createProxyUrl ?? "https://cs.pxy.yagnyam.in/proxy",
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client {
    assert(isNotEmpty(this.createProxyUrl));
  }

  Future<Proxy> createProxy(ProxyRequest proxyRequest) async {
    ProxyCreationRequest request = ProxyCreationRequest(
      requestId: uuidFactory.v4(),
      proxyId: proxyRequest.id,
      revocationPassPhraseSha256: proxyRequest.revocationPassPhraseSha256,
      certificateRequestEncoded: proxyRequest.requestEncoded,
    );
    String jsonResponse = await post(httpClientFactory(), createProxyUrl, body: jsonEncode(request.toJson()));
    ProxyCreationResponse proxyCreationResponse = ProxyCreationResponse.fromJson(jsonDecode(jsonResponse));
    return proxyCreationResponse.proxy;
  }
}
