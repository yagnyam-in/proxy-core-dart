import 'package:asn1lib/asn1lib.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/services.dart';
import 'package:proxy_core/src/bootstrap/proxy_request.dart';
import 'package:proxy_core/src/bootstrap/proxy_request_factory.dart';
import 'package:proxy_core/src/core/proxy_key.dart';
import "package:x509csr/x509csr.dart";

class PointyCastleProxyRequestFactory extends ProxyRequestFactory {
  final CryptographyService cryptographyService;

  PointyCastleProxyRequestFactory(this.cryptographyService);

  @override
  Future<ProxyRequest> createProxyRequest({
    @required ProxyKey proxyKey,
    @required String signatureAlgorithm,
    @required String revocationPassPhrase,
  }) {
    if (signatureAlgorithm == 'SHA256WithRSAEncryption') {
      return createProxyRequestForSha256WithRSAEncryption(
        proxyKey: proxyKey,
        revocationPassPhrase: revocationPassPhrase,
      );
    }
    throw ArgumentError("Unsupported signature algorithm $signatureAlgorithm");
  }

  Future<ProxyRequest> createProxyRequestForSha256WithRSAEncryption({
    @required ProxyKey proxyKey,
    @required String revocationPassPhrase,
  }) async {
    ASN1ObjectIdentifier.registerFrequentNames();
    Map<String, String> dn = {
      "CN": proxyKey.id.id,
    };
    assert(proxyKey.publicKey != null);
    assert(proxyKey.privateKey != null);
    ASN1Object encodedCSR = makeRSACSR(dn, proxyKey.privateKey, proxyKey.publicKey);
    String requestEncoded = encodeCSRToPem(encodedCSR);
    /* TODO: Not right */
    String revocationPassPhraseSha256 = await cryptographyService.getSha256Hmac(
      key: revocationPassPhrase,
      input: proxyKey.id.id,
    );
    return ProxyRequest(
      id: proxyKey.id.id,
      requestEncoded: requestEncoded,
      revocationPassPhraseSha256: revocationPassPhraseSha256,
    );
  }
}
