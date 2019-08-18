import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/src/core/message_builder.dart';
import 'package:proxy_core/src/core/multi_signable_message.dart';
import 'package:proxy_core/src/core/multi_signed_message.dart';
import 'package:proxy_core/src/core/proxy_id.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

part 'subscribe_for_alerts_request.g.dart';

@JsonSerializable()
class SubscribeForAlertsRequest extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final String requestId;

  @JsonKey(nullable: false)
  final ProxyId proxyId;

  @JsonKey(nullable: false)
  final String deviceId;

  @JsonKey(nullable: false)
  final String fcmToken;

  // TODO: Make this mandatory
  @JsonKey(nullable: true)
  final ProxyId alertProviderProxyId;

  SubscribeForAlertsRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.deviceId,
    @required this.fcmToken,
    this.alertProviderProxyId,
  });

  @override
  void assertValid() {
    assert(isNotEmpty(requestId));
    assertValidProxyId(proxyId);
    assert(isNotEmpty(deviceId));
    assert(isNotEmpty(fcmToken));
    if (alertProviderProxyId != null) {
      assertValidProxyId(alertProviderProxyId);
    }
  }

  @override
  bool isValid() {
    return isNotEmpty(requestId) &&
        isValidProxyId(proxyId) &&
        isNotEmpty(deviceId) &&
        isNotEmpty(fcmToken) &&
        (alertProviderProxyId == null || isValidProxyId(alertProviderProxyId));
  }

  @override
  List<SignedMessage<SignableMessage>> getSignedChildMessages() {
    return [];
  }

  @override
  List<MultiSignedMessage<MultiSignableMessage>> getMultiSignedChildMessages() {
    return [];
  }

  @override
  String get messageType => "in.yagnyam.proxy.messages.alerts.SubscribeForAlertsRequest";

  @override
  ProxyId getSigner() => proxyId;

  @override
  String toReadableString() {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$SubscribeForAlertsRequestToJson(this);

  static SubscribeForAlertsRequest fromJson(Map json) => _$SubscribeForAlertsRequestFromJson(json);

  static SignedMessage<SubscribeForAlertsRequest> signedMessageFromJson(Map json) {
    SignedMessage<SubscribeForAlertsRequest> signedMessage = SignedMessage.fromJson<SubscribeForAlertsRequest>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }
}
