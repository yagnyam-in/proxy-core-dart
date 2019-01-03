import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'certificate_service.dart';

class ProxyResolver {

  final CertificateService certificateService;

  ProxyResolver({@required this.certificateService}): assert(certificateService != null);

  Future<List<Proxy>> resolveProxy(ProxyId proxyId) async {
    assert(proxyId != null);
    Certificates certificates = await certificateService.getCertificatesById(proxyId.id, proxyId.sha256Thumbprint);
    return certificates.certificates.map((c) => Proxy.fromCertificate(c));
  }
}
