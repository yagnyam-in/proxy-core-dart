import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'proxy_id.g.dart';

@JsonSerializable()
class ProxyId extends ProxyBaseObject with ProxyUtils {
  static final ID_REGEX = RegExp(r"^[a-zA-Z][a-zA-Z0-9-]{0,34}[a-zA-Z0-9]$");

  static ProxyId _any = ProxyId('any');

  @JsonKey(nullable: false)
  final String id;

  @JsonKey(nullable: true, includeIfNull: false)
  final String sha256Thumbprint;

  ProxyId(this.id, [this.sha256Thumbprint = null])
      : assert(isNotEmpty(id)),
        assert(sha256Thumbprint == null || isNotEmpty(sha256Thumbprint));

  @deprecated
  ProxyId.nonSafe({this.id, this.sha256Thumbprint}) {
    Logger('proxy.core.ProxyId').shout("ProxyId.nonSafe is being used");
  }

  factory ProxyId.any() {
    return _any;
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! ProxyId) {
      return false;
    }
    ProxyId otherProxyId = other as ProxyId;
    return id == otherProxyId.id && sha256Thumbprint == otherProxyId.sha256Thumbprint;
  }

  /// Can `this` ProxyId sign on behalf of `other` ProxyId??
  ///
  bool canSignOnBehalfOf(ProxyId other) {
    if (other == null) {
      return false;
    }
    if (other == ProxyId.any()) {
      return true;
    }
    if (other.id == id && other.sha256Thumbprint == null) {
      return true;
    }
    return this == other;
  }

  /// ProxyId as string
  @JsonKey(ignore: true)
  String get uniqueId {
    if (sha256Thumbprint != null) {
      return "$id#$sha256Thumbprint";
    } else {
      return id;
    }
  }

  String toString() {
    return uniqueId;
  }

  @override
  bool isValid() {
    return isValidId(id) && (sha256Thumbprint == null || isNotEmpty(sha256Thumbprint));
  }

  static bool isValidId(String id) {
    return id != null && ID_REGEX.hasMatch(id);
  }

  factory ProxyId.fromJson(Map<String, dynamic> json) => _$ProxyIdFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyIdToJson(this);

}
