
import 'package:proxy_core/src/core/proxy_request.dart';

abstract class ProxyRequestService {

  Future<ProxyRequest> createCertificateRequest(String id, String signatureAlgorithm);
}
