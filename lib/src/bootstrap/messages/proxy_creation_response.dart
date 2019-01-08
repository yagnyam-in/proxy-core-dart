import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

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
  })  : assert(request != null && request.isValid()),
        assert(proxy != null && proxy.isValid());

  ProxyCreationResponse.nonSafe({
    this.request,
    this.proxy,
  });

  @override
  bool isValid() {
    return (request != null && request.isValid()) &&
        (proxy != null && proxy.isValid());
  }

  factory ProxyCreationResponse.fromJson(Map<String, dynamic> json) => _$ProxyCreationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyCreationResponseToJson(this);

  @override
  List<SignedMessage<SignableMessage>> getChildMessages() {
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
