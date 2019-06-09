import 'package:proxy_core/core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'proxy_creation_request.g.dart';

@JsonSerializable()
class ProxyCreationRequest extends ProxyBaseObject with ProxyUtils {
  /**
   * Unique Request Id. No two requests shall have same request number
   */
  @JsonKey(nullable: false)
  final String requestId;

  /**
   * Unique Proxy Id
   */
  @JsonKey(nullable: false)
  final String proxyId;

  /**
   * Pass phrase to de-activate a given Proxy (sha256(proxyId#passPhrase))
   */
  @JsonKey(nullable: false)
  final String revocationPassPhraseSha256;

  /**
   * Valid Certificate Request for Subject requestId. This is to prevent misusing un-protected
   * endpoint to get new PID
   */
  @JsonKey(nullable: false)
  final String certificateRequestEncoded;

  ProxyCreationRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.revocationPassPhraseSha256,
    @required this.certificateRequestEncoded,
  })  {
    assertValid();
  }

  ProxyCreationRequest.nonSafe({
    this.requestId,
    this.proxyId,
    this.revocationPassPhraseSha256,
    this.certificateRequestEncoded,
  });

  @override
  bool isValid() {
    return isNotEmpty(requestId) &&
        ProxyId.isValidId(proxyId) &&
        isNotEmpty(revocationPassPhraseSha256) &&
        isNotEmpty(certificateRequestEncoded);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(requestId));
    assert(ProxyId.isValidId(proxyId));
    assert(isNotEmpty(revocationPassPhraseSha256));
    assert(isNotEmpty(certificateRequestEncoded));
  }

  factory ProxyCreationRequest.fromJson(Map json) => _$ProxyCreationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyCreationRequestToJson(this);
}
