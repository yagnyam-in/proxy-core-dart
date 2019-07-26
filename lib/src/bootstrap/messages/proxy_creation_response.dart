import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/multi_signable_message.dart';
import 'package:proxy_core/src/core/multi_signed_message.dart';

import 'proxy_creation_request.dart';

part 'proxy_creation_response.g.dart';

@JsonSerializable()
class ProxyCreationResponse extends SignableMessage with ProxyUtils {
  /**
   * Request message
   */
  @JsonKey(nullable: false)
  final ProxyCreationRequest request;

  /**
   * Proxy
   */
  @JsonKey(nullable: false)
  final Proxy proxy;

  ProxyCreationResponse({
    @required this.request,
    @required this.proxy,
  }) {
    assertValid();
  }

  ProxyCreationResponse.nonSafe({
    this.request,
    this.proxy,
  });

  @override
  bool isValid() {
    return (request != null && request.isValid()) && (proxy != null && proxy.isValid());
  }

  @override
  void assertValid() {
    assert(request != null);
    request.assertValid();
    assert(proxy != null);
    proxy.assertValid();
  }

  factory ProxyCreationResponse.fromJson(Map json) => _$ProxyCreationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyCreationResponseToJson(this);

  @override
  List<SignedMessage<SignableMessage>> getSignedChildMessages() {
    return [];
  }

  @override
  List<MultiSignedMessage<MultiSignableMessage>> getMultiSignedChildMessages() {
    return [];
  }

  @override
  String get messageType => 'in.yagnyam.proxy.messages.registration.ProxyCreationResponse';

  @override
  String toReadableString() {
    return null;
  }

  @override
  ProxyId getSigner() => ProxyId(ProxyConstants.PROXY_CENTRAL);
}
