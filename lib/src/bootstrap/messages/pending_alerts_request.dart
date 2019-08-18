import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/src/core/message_builder.dart';
import 'package:proxy_core/src/core/multi_signable_message.dart';
import 'package:proxy_core/src/core/multi_signed_message.dart';
import 'package:proxy_core/src/core/proxy_id.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

part 'pending_alerts_request.g.dart';

@JsonSerializable()
class PendingAlertsRequest extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final String requestId;

  @JsonKey(nullable: false)
  final ProxyId proxyId;

  @JsonKey(nullable: false)
  final String deviceId;

  @JsonKey(nullable: true)
  final DateTime fromTime;

  // TODO: Make this mandatory
  @JsonKey(nullable: true)
  final ProxyId alertProviderProxyId;

  PendingAlertsRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.deviceId,
    this.fromTime,
    this.alertProviderProxyId,
  });

  @override
  void assertValid() {
    assert(isNotEmpty(requestId));
    assertValidProxyId(proxyId);
    assert(isNotEmpty(deviceId));
    if (fromTime != null) {
      assertValidDateTime(fromTime);
    }
    if (alertProviderProxyId != null) {
      assertValidProxyId(alertProviderProxyId);
    }
  }

  @override
  bool isValid() {
    return isNotEmpty(requestId) &&
        isValidProxyId(proxyId) &&
        isNotEmpty(deviceId) &&
        (fromTime == null || isValidDateTime(fromTime)) &&
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
  String get messageType => "in.yagnyam.proxy.messages.alerts.PendingAlertsRequest";

  @override
  ProxyId getSigner() => proxyId;

  @override
  String toReadableString() {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$PendingAlertsRequestToJson(this);

  static PendingAlertsRequest fromJson(Map json) => _$PendingAlertsRequestFromJson(json);

  static SignedMessage<PendingAlertsRequest> signedMessageFromJson(Map json) {
    SignedMessage<PendingAlertsRequest> signedMessage = SignedMessage.fromJson<PendingAlertsRequest>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }
}
