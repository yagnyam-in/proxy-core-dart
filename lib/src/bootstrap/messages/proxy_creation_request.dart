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
   * Pass phrase to de-activate a given Proxy
   */
  @JsonKey(nullable: false)
  final HashValue revocationPassPhraseHash;

  /**
   * Valid Certificate Request for Subject requestId. This is to prevent misusing un-protected
   * endpoint to get new PID
   */
  @JsonKey(nullable: false)
  final String certificateRequestEncoded;

  ProxyCreationRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.revocationPassPhraseHash,
    @required this.certificateRequestEncoded,
  }) {
    assertValid();
  }

  ProxyCreationRequest.nonSafe({
    this.requestId,
    this.proxyId,
    this.revocationPassPhraseHash,
    this.certificateRequestEncoded,
  });

  @override
  bool isValid() {
    return isNotEmpty(requestId) &&
        ProxyId.isValidId(proxyId) &&
        isValidProxyObject(revocationPassPhraseHash) &&
        isNotEmpty(certificateRequestEncoded);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(requestId));
    assert(ProxyId.isValidId(proxyId));
    assert(isValidProxyObject(revocationPassPhraseHash));
    assert(isNotEmpty(certificateRequestEncoded));
  }

  factory ProxyCreationRequest.fromJson(Map json) => _$ProxyCreationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyCreationRequestToJson(this);
}
