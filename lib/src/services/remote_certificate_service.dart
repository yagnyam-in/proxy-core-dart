import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'certificate_service.dart';
import 'proxy_http_client.dart';

typedef CertificateIdToUrl = String Function(String id,
    [String sha256Thumbprint]);

typedef CertificateSerialNumberToUrl = String Function(String serialNumber);

typedef HttpClientFactory = http.Client Function();

class RemoteCertificateService
    with ProxyUtils, HttpClientUtils
    implements CertificateService {
  final Logger logger = Logger('proxy.services.RemoteCertificateService');

  final CertificateIdToUrl certificatesByIdUrl;

  final CertificateSerialNumberToUrl certificateBySerialNumberUrl;

  final HttpClientFactory httpClientFactory;

  RemoteCertificateService({
    @required this.certificatesByIdUrl,
    @required this.certificateBySerialNumberUrl,
    HttpClientFactory httpClientFactory,
  })  : assert(certificatesByIdUrl != null),
        assert(certificateBySerialNumberUrl != null),
        httpClientFactory = httpClientFactory ?? ProxyHttpClient.client;

  @override
  Future<Certificate> getCertificateBySerialNumber(String serialNumber) async {
    assert(isNotEmpty(serialNumber));
    String response = await get(
        httpClientFactory(), certificateBySerialNumberUrl(serialNumber));
    return Certificate.fromJson(jsonDecode(response));
  }

  @override
  Future<CertificateChain> getCertificateChain(String certificateId,
      [String sha256Thumbprint]) async {
    assert(isNotEmpty(certificateId));
    assert(sha256Thumbprint == null || isNotEmpty(sha256Thumbprint));
    String response = await get(httpClientFactory(),
        certificatesByIdUrl(certificateId, sha256Thumbprint));
    return CertificateChain.fromJson(jsonDecode(response));
  }

  @override
  Future<Certificates> getCertificatesById(String certificateId,
      [String sha256Thumbprint]) async {
    assert(isNotEmpty(certificateId));
    assert(sha256Thumbprint == null || isNotEmpty(sha256Thumbprint));
    String response = await get(httpClientFactory(),
        certificatesByIdUrl(certificateId, sha256Thumbprint));
    return Certificates.fromJson(jsonDecode(response));
  }
}
