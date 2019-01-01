import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/proxy_id.dart';
import 'package:proxy_core/proxy_object.dart';
import 'package:proxy_core/proxy_utils.dart';

part 'certificate.g.dart';

@JsonSerializable()
class Certificate extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String serialNumber;

  @JsonKey(nullable: false)
  final String owner;

  @JsonKey(nullable: false)
  final String sha256Thumbprint;

  @JsonKey(nullable: true, includeIfNull: false)
  final String alias;

  @JsonKey(nullable: false)
  final String subject;

  @JsonKey(nullable: false)
  final DateTime validFrom;

  @JsonKey(nullable: false)
  final DateTime validTill;

  @JsonKey(nullable: false)
  final String certificateEncoded;

  Certificate({
    @required this.serialNumber,
    @required this.owner,
    @required this.sha256Thumbprint,
    this.alias,
    @required this.subject,
    @required this.validFrom,
    @required this.validTill,
    @required this.certificateEncoded,
  });

  String getId() {
    return owner;
  }

  String getUniqueId() {
    return owner + "#" + sha256Thumbprint;
  }

  bool matchesCertificateId(String certificateId) {
    if (owner == extractOnlyId(certificateId)) {
      String sha256 = extractSha256Thumbprint(certificateId);
      return sha256 == null || sha256Thumbprint == sha256;
    }
    return false;
  }

  bool matchesProxyId(ProxyId proxyId) {
    return proxyId != null &&
        proxyId.id == owner &&
        (proxyId.sha256Thumbprint == null || proxyId.sha256Thumbprint == sha256Thumbprint);
  }

  @override
  bool isValid() {
    return isNotEmpty(serialNumber) &&
        isNotEmpty(owner) &&
        isNotEmpty(sha256Thumbprint) &&
        isNotEmpty(subject) &&
        isValidDateTime(validFrom) &&
        isValidDateTime(validTill) &&
        isNotEmpty(certificateEncoded);
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! Certificate) {
      return false;
    }
    Certificate otherCertificate = other as Certificate;
    return serialNumber == otherCertificate.serialNumber &&
        owner == otherCertificate.owner &&
        sha256Thumbprint == otherCertificate.sha256Thumbprint &&
        alias == otherCertificate.alias &&
        subject == otherCertificate.subject &&
        validFrom == otherCertificate.validFrom &&
        validTill == otherCertificate.validTill &&
        certificateEncoded == otherCertificate.certificateEncoded;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory Certificate.fromJson(Map<String, dynamic> json) => _$CertificateFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateToJson(this);

  static String extractOnlyId(String certificateUniqueId) {
    if (certificateUniqueId == null || certificateUniqueId.trim().isEmpty) {
      throw ArgumentError("Invalid certificate Id");
    }
    List<String> tokens = certificateUniqueId.split("#");
    if (tokens.length <= 2) {
      return tokens[0];
    } else {
      throw ArgumentError("Invalid certificate Id" + certificateUniqueId);
    }
  }

  static String extractSha256Thumbprint(String certificateUniqueId) {
    if (certificateUniqueId == null || certificateUniqueId.trim().isEmpty) {
      throw ArgumentError("Invalid certificate Id");
    }
    List<String> tokens = certificateUniqueId.split("#");
    if (tokens.length < 2) {
      return null;
    } else if (tokens.length == 2) {
      return tokens[1];
    } else {
      throw ArgumentError("Invalid certificate Id" + certificateUniqueId);
    }
  }
}
