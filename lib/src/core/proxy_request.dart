import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'proxy_utils.dart';

part 'proxy_request.g.dart';

@JsonSerializable()
class ProxyRequest with ProxyUtils {
  @JsonKey(nullable: false)
  final String id;

  @JsonKey(nullable: true, includeIfNull: false)
  final String alias;

  @JsonKey(nullable: false)
  final String requestEncoded;

  ProxyRequest({
    @required this.id,
    this.alias,
    @required this.requestEncoded,
  })  : assert(isNotEmpty(id)),
        assert(isNotEmpty(requestEncoded));

  @deprecated
  ProxyRequest.nonSafe({
    @required this.id,
    this.alias,
    @required this.requestEncoded,
  }) {
    Logger('proxy.core.ProxyRequest')
        .shout("ProxyRequest.nonSafe is being used");
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! ProxyRequest) {
      return false;
    }
    ProxyRequest otherCertificate = other as ProxyRequest;
    return id == otherCertificate.id &&
        alias == otherCertificate.alias &&
        requestEncoded == otherCertificate.requestEncoded;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory ProxyRequest.fromJson(Map<String, dynamic> json) =>
      _$ProxyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyRequestToJson(this);
}
