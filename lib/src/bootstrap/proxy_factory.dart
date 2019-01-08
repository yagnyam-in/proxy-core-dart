import 'dart:convert';

import 'package:uuid/uuid.dart';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';

import 'messages/proxy_creation_request.dart';
import 'messages/proxy_creation_response.dart';
import 'proxy_request.dart';

/// Create Proxy
class ProxyFactory with ProxyUtils, HttpClientUtils {
  final Logger logger = Logger('proxy.services.RemoteCertificateService');
  final Uuid uuidFactory = Uuid();

  final String createProxyUrl;
  final HttpClientFactory httpClientFactory;

  ProxyFactory(
      {@required String createProxyUrl, HttpClientFactory httpClientFactory})
      : createProxyUrl = createProxyUrl ?? "http://proxy-cs.appspot.com/proxy",
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client {
    assert(isNotEmpty(createProxyUrl));
  }

  Future<Proxy> createProxy(ProxyRequest proxyRequest) async {
    ProxyCreationRequest request = ProxyCreationRequest(
      requestId: uuidFactory.v4(),
      proxyId: proxyRequest.id,
      revocationPassPhraseSha256: proxyRequest.revocationPassPhraseSha256,
      certificateRequestEncoded: proxyRequest.requestEncoded,
    );
    String jsonResponse = await post(
        httpClientFactory(), createProxyUrl, jsonEncode(request.toJson()));
    ProxyCreationResponse proxyCreationResponse =
        ProxyCreationResponse.fromJson(jsonDecode(jsonResponse));
    return proxyCreationResponse.proxy;
  }
}
