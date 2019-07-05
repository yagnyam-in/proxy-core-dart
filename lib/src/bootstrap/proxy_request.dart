import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

part 'proxy_request.g.dart';

@JsonSerializable()
class ProxyRequest extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String id;

  @JsonKey(nullable: false)
  final HashValue revocationPassPhraseHash;

  @JsonKey(nullable: false)
  final String requestEncoded;

  ProxyRequest({
    @required this.id,
    @required this.revocationPassPhraseHash,
    @required this.requestEncoded,
  }) {
    assertValid();
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! ProxyRequest) {
      return false;
    }
    ProxyRequest otherRequest = other as ProxyRequest;
    return id == otherRequest.id &&
        revocationPassPhraseHash == otherRequest.revocationPassPhraseHash &&
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
    return ProxyId.isValidId(id) && isValidProxyObject(revocationPassPhraseHash) && isNotEmpty(requestEncoded);
  }

  @override
  void assertValid() {
    assert(ProxyId.isValidId(id));
    assert(isValidProxyObject(revocationPassPhraseHash));
    assert(isNotEmpty(requestEncoded));
  }
}
