
import 'package:proxy_core/core.dart';

abstract class ProxyResolver {
  Future<Certificate> getCertificateBySerialNumber(String serialNumber);

  Future<Certificates> getCertificatesById(String certificateId, [String sha256Thumbprint]);

  Future<CertificateChain> getCertificateChain(String certificateId, [String sha256Thumbprint]);
}
