import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'certificate.dart';
import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'proxy.g.dart';

@JsonSerializable()
class Proxy extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final ProxyId id;

  @JsonKey(nullable: true, includeIfNull: false)
  final String name;

  @JsonKey(nullable: false)
  final String certificateSerialNumber;

  @JsonKey(nullable: false)
  final Certificate certificate;

  Proxy(
      {@required this.id,
      this.name,
      @required this.certificateSerialNumber,
      @required this.certificate})
      : assert(id != null && id.isValid()),
        assert(isNotEmpty(certificateSerialNumber)),
        assert(certificate != null && certificate.isValid());

  Proxy.from(Certificate certificate)
      : assert(certificate != null && certificate.isValid()),
        id = ProxyId(certificate.id, certificate.sha256Thumbprint),
        certificateSerialNumber = certificate.serialNumber,
        name = certificate.alias,
        certificate = certificate;

  Proxy._noAssertions(
      {this.id, this.name, this.certificateSerialNumber, this.certificate});

  @override
  bool isValid() {
    return id != null &&
        id.isValid() &&
        isNotEmpty(certificateSerialNumber) &&
        certificate != null &&
        certificate.isValid();
  }

  String toString() {
    return {
      "id": id,
      "name": name,
      "certificateSerialNumber": certificateSerialNumber,
    }.toString();
  }

  factory Proxy.fromJson(Map<String, dynamic> json) => _$ProxyFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyToJson(this);
}
