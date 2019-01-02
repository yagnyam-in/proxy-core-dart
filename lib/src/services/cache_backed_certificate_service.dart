
import 'package:proxy_core/core.dart';
import 'certificate_service.dart';

class CacheBackedCertificateService implements CertificateService {

  final CertificateService underlyingCertificateService;

  CacheBackedCertificateService(this.underlyingCertificateService);

  @override
  Future<Certificate> getCertificateBySerialNumber(String serialNumber) {
    return underlyingCertificateService.getCertificateBySerialNumber(serialNumber);
  }

  @override
  Future<CertificateChain> getCertificateChain(String certificateId) {
    return underlyingCertificateService.getCertificateChain(certificateId);
  }

  @override
  Future<Certificates> getCertificatesById(String certificateId) {
    return underlyingCertificateService.getCertificatesById(certificateId);
  }


}
