
import 'proxy_request.dart';

abstract class ProxyRequestFactory {

  Future<ProxyRequest> createProxyRequest({String id, String signatureAlgorithm, String revocationPassPhrase, String keyGenerationAlgorithm, int keySize});
}
