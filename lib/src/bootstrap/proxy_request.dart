import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

part 'proxy_request.g.dart';

@JsonSerializable()
class ProxyRequest extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String id;

  @JsonKey(nullable: false)
  final String revocationPassPhraseSha256;

  @JsonKey(nullable: false)
  final String requestEncoded;

  ProxyRequest({
    @required this.id,
    @required this.revocationPassPhraseSha256,
    @required this.requestEncoded,
  })  {
    assertValid();
  }

  @deprecated
  ProxyRequest.nonSafe({
    this.id,
    this.revocationPassPhraseSha256,
    this.requestEncoded,
  }) {
    Logger('proxy.core.ProxyRequest').shout("ProxyRequest.nonSafe is being used");
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! ProxyRequest) {
      return false;
    }
    ProxyRequest otherRequest = other as ProxyRequest;
    return id == otherRequest.id &&
        revocationPassPhraseSha256 == otherRequest.revocationPassPhraseSha256 &&
        requestEncoded == otherRequest.requestEncoded;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory ProxyRequest.fromJson(Map json) => _$ProxyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyRequestToJson(this);

  @override
  bool isValid() {
    return ProxyId.isValidId(id) && isNotEmpty(revocationPassPhraseSha256) && isNotEmpty(requestEncoded);
  }

  @override
  void assertValid() {
    assert(ProxyId.isValidId(id));
    assert(isNotEmpty(revocationPassPhraseSha256));
    assert(isNotEmpty(requestEncoded));
  }
}
