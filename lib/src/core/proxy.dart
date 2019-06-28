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
  final Certificate certificate;

  @JsonKey(nullable: false)
  final String publicKeyEncoded;

  @JsonKey(nullable: false)
  final String publicKeySha256Thumbprint;

  Proxy({
    @required this.id,
    @required this.certificate,
    @required this.publicKeyEncoded,
    @required this.publicKeySha256Thumbprint,
    this.name,
  }) {
    assertValid();
  }

  Proxy.fromCertificate(Certificate certificate)
      : assert(certificate != null && certificate.isValid()),
        id = ProxyId(certificate.id, certificate.sha256Thumbprint),
        name = certificate.alias,
        certificate = certificate,
        publicKeyEncoded = certificate.publicKeyEncoded,
        publicKeySha256Thumbprint = certificate.publicKeySha256Thumbprint;

  String toString() {
    return {
      "id": id,
      "name": name,
    }.toString();
  }

  @override
  bool isValid() {
    return isValidProxyId(id) &&
        isNotEmpty(publicKeyEncoded) &&
        isNotEmpty(publicKeySha256Thumbprint) &&
        (certificate != null && certificate.isValid());
  }

  void assertValid() {
    assert(isValidProxyId(id));
    assert(isNotEmpty(publicKeyEncoded));
    assert(isNotEmpty(publicKeySha256Thumbprint));
    assert(certificate != null);
    certificate.assertValid();
  }

  factory Proxy.fromJson(Map json) => _$ProxyFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyToJson(this);
}
