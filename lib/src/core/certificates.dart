import 'package:json_annotation/json_annotation.dart';
import 'certificate.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'certificates.g.dart';

@JsonSerializable()
class Certificates extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final List<Certificate> certificates;

  Certificates(this.certificates) {
    assertValid();
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory Certificates.fromJson(Map json) => _$CertificatesFromJson(json);

  Map<String, dynamic> toJson() => _$CertificatesToJson(this);

  @override
  bool isValid() {
    return isNonEmptyProxyObjectList(certificates);
  }

  @override
  void assertValid() {
    assertNonEmptyProxyObjectList(certificates);
  }
}
