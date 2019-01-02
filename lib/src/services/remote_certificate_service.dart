import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

import 'certificate_service.dart';
import 'proxy_http_client.dart';

typedef StringToString = String Function(String id);

typedef HttpClientFactory = http.Client Function();

class RemoteCertificateService implements CertificateService {
  final Logger logger = new Logger('proxy.services.RemoteCertificateService');

  final StringToString certificatesByIdUrl;

  final StringToString certificateBySerialNumberUrl;

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
    String response = await get(certificateBySerialNumberUrl(serialNumber));
    return Certificate.fromJson(jsonDecode(response));
  }

  @override
  Future<CertificateChain> getCertificateChain(String certificateId) async {
    String response = await get(certificatesByIdUrl(certificateId));
    return CertificateChain.fromJson(jsonDecode(response));
  }

  @override
  Future<Certificates> getCertificatesById(String certificateId) async {
    String response = await get(certificatesByIdUrl(certificateId));
    return Certificates.fromJson(jsonDecode(response));
  }

  Future<String> get(String url) async {
    http.Client httpClient = httpClientFactory();
    try {
      http.Response response = await httpClient.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      logger.info(
          "GET $url failed with ${response.statusCode}: ${response.body}");
      throw HttpException(
          "GET $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      httpClient.close();
    }
  }
}
