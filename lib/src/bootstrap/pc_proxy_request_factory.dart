import 'package:asn1lib/asn1lib.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';
import 'package:proxy_core/src/bootstrap/proxy_request.dart';
import 'package:proxy_core/src/bootstrap/proxy_request_factory.dart';
import 'package:proxy_core/src/core/proxy_key.dart';
import "package:x509csr/x509csr.dart";

class PointyCastleProxyRequestFactory extends ProxyRequestFactory {
  final CryptographyService cryptographyService;

  final ProxyVersion proxyVersion;

  PointyCastleProxyRequestFactory(this.proxyVersion, this.cryptographyService);

  @override
  Future<ProxyRequest> createProxyRequest({
    @required ProxyKey proxyKey,
    @required String revocationPassPhrase,
  }) {
    if (proxyVersion.certificateSignatureAlgorithm == 'SHA256WithRSAEncryption'.toUpperCase()) {
      return createProxyRequestForSha256WithRSAEncryption(
        proxyKey: proxyKey,
        revocationPassPhrase: revocationPassPhrase,
      );
    }
    throw ArgumentError("Unsupported signature algorithm ${proxyVersion.certificateSignatureAlgorithm}");
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
    HashValue revocationPassPhraseHash = await cryptographyService.getHash(
      hashAlgorithm: proxyVersion.preferredHashAlgorithm,
      input: revocationPassPhrase,
    );
    return ProxyRequest(
      id: proxyKey.id.id,
      requestEncoded: requestEncoded,
      revocationPassPhraseHash: revocationPassPhraseHash,
    );
  }
}
