import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/bootstrap.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/multi_signable_message.dart';
import 'package:proxy_core/src/core/multi_signed_message.dart';

part 'pending_alerts_response.g.dart';

@JsonSerializable()
class PendingAlertsResponse extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final SignedMessage<PendingAlertsRequest> request;

  @JsonKey(nullable: false, fromJson: signedAlertsFromJson)
  final List<SignedMessage<SignableAlertMessage>> alerts;

  @JsonKey(nullable: true)
  final DateTime tillTime;

  PendingAlertsResponse({
    @required this.request,
    @required this.alerts,
    this.tillTime,
  }) {
    assertValid();
  }

  @override
  bool isValid() {
    return isValidProxyObject(request) &&
        isValidProxyObjectList(alerts) &&
        (tillTime != null || isValidDateTime(tillTime));
  }

  @override
  void assertValid() {
    assertValidProxyObject(request);
    assertValidProxyObjectList(alerts);
    if (tillTime != null) {
      assertValidDateTime(tillTime);
    }
  }

  Map<String, dynamic> toJson() => _$PendingAlertsResponseToJson(this);

  @override
  List<SignedMessage<SignableMessage>> getSignedChildMessages() {
    return alerts;
  }

  @override
  List<MultiSignedMessage<MultiSignableMessage>> getMultiSignedChildMessages() {
    return [];
  }

  @override
  String get messageType => 'in.yagnyam.proxy.messages.alerts.PendingAlertsResponse';

  @override
  String toReadableString() {
    return null;
  }

  @override
  ProxyId getSigner() => ProxyId(ProxyConstants.PROXY_CENTRAL);

  static PendingAlertsResponse fromJson(Map json) => _$PendingAlertsResponseFromJson(json);

  static SignedMessage<PendingAlertsResponse> signedMessageFromJson(Map json) {
    if (json == null) return null;
    SignedMessage<PendingAlertsResponse> signedMessage = SignedMessage.fromJson<PendingAlertsResponse>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }

  static List<SignedMessage<SignableAlertMessage>> signedAlertsFromJson(List alerts) {
    return alerts.map((e) => SignedMessage.fromJson<SignableAlertMessage>(e as Map)).toList();
  }
}
