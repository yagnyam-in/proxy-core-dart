
import 'package:proxy_core/src/core/proxy_request.dart';

abstract class ProxyRequestFactory {

  Future<ProxyRequest> createCertificateRequest(String id, String signatureAlgorithm, String revocationPassPhrase);
}
