import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'certificate.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'certificate_chain.g.dart';

@JsonSerializable()
class CertificateChain extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: true, includeIfNull: false)
  final String certificateSerial;

  @JsonKey(nullable: true, includeIfNull: false)
  final String certificateId;

  @JsonKey(nullable: false)
  final List<Certificate> certificates;

  CertificateChain({
    this.certificateSerial,
    this.certificateId,
    @required this.certificates,
  }) {
    assertValid();
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory CertificateChain.fromJson(Map json) => _$CertificateChainFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateChainToJson(this);

  @override
  bool isValid() {
    return (certificateSerial == null || isNotEmpty(certificateSerial)) &&
        (certificateId == null || isNotEmpty(certificateId)) &&
        isNonEmptyProxyObjectList(certificates);
  }

  @override
  void assertValid() {
    assert(certificateSerial == null || isNotEmpty(certificateSerial));
    assert(certificateId == null || isNotEmpty(certificateId));
    assert(isNonEmptyProxyObjectList(certificates));
  }
}
