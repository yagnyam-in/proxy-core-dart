import 'package:proxy_core/certificate.dart';
import 'package:proxy_core/certificate_chain.dart';
import 'package:proxy_core/certificates.dart';

abstract class CertificateService {
  Future<Certificate> getCertificateBySerialNumber(String serialNumber);

  Future<Certificates> getCertificatesById(String certificateId);

  Future<CertificateChain> getCertificateChain(String certificateId);
}
