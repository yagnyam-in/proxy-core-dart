import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'certificate.dart';
import 'proxy_id.dart';
import 'proxy_utils.dart';

import 'proxy_object.dart';

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

  Proxy({
    @required this.id,
    this.name,
    @required this.certificateSerialNumber,
    @required this.certificate,
  })  : assert(isValidProxyId(id)),
        assert(isNotEmpty(certificateSerialNumber)),
        assert(certificate != null && certificate.isValid());

  Proxy.fromCertificate(Certificate certificate)
      : assert(certificate != null && certificate.isValid()),
        id = ProxyId(certificate.id, certificate.sha256Thumbprint),
        certificateSerialNumber = certificate.serialNumber,
        name = certificate.alias,
        certificate = certificate;

  String toString() {
    return {
      "id": id,
      "name": name,
      "certificateSerialNumber": certificateSerialNumber,
    }.toString();
  }

  @override
  bool isValid() {
    return isValidProxyId(id) && isNotEmpty(certificateSerialNumber) && (certificate != null && certificate.isValid());
  }

  factory Proxy.fromJson(Map<String, dynamic> json) => _$ProxyFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyToJson(this);
}
