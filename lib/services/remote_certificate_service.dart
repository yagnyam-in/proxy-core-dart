import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:proxy_core/certificate.dart';
import 'package:proxy_core/certificate_chain.dart';
import 'package:proxy_core/certificates.dart';
import 'package:proxy_core/services/certificate_service.dart';

typedef StringToString = String Function(String id);

class RemoteCertificateService implements CertificateService {
  final Logger logger = new Logger('MyClassName');

  final StringToString certificatesByIdUrl;

  final StringToString certificateBySerialNumberUrl;

  RemoteCertificateService(this.certificatesByIdUrl, this.certificateBySerialNumberUrl)
      : assert(certificatesByIdUrl != null),
        assert(certificateBySerialNumberUrl != null);

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
    var client = new http.Client();
    try {
      http.Response response = await client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      logger.info("GET $url failed with ${response.statusCode}: ${response.body}");
      throw HttpException("GET $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      client.close();
    }
  }
}
