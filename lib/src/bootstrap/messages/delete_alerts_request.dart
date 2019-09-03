import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/message_builder.dart';
import 'package:proxy_core/src/core/multi_signable_message.dart';
import 'package:proxy_core/src/core/multi_signed_message.dart';
import 'package:proxy_core/src/core/proxy_id.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

part 'delete_alerts_request.g.dart';

@JsonSerializable()
class AlertId extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String proxyUniverse;

  @JsonKey(nullable: false)
  final String alertId;

  @JsonKey(nullable: false)
  final String alertType;

  AlertId({@required this.proxyUniverse, @required this.alertId, @required this.alertType}) {
    assertValid();
  }

  @override
  void assertValid() {
    assert(isNotEmpty(proxyUniverse));
    assert(isNotEmpty(alertType));
    assert(isNotEmpty(alertId));
  }

  @override
  bool isValid() {
    return isNotEmpty(proxyUniverse) && isNotEmpty(alertType) && isNotEmpty(alertId);
  }

  Map<String, dynamic> toJson() => _$AlertIdToJson(this);

  static AlertId fromJson(Map json) => _$AlertIdFromJson(json);
}

@JsonSerializable()
class DeleteAlertsRequest extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final String requestId;

  @JsonKey(nullable: false)
  final ProxyId proxyId;

  @JsonKey(nullable: false)
  final String deviceId;

  @JsonKey(nullable: false)
  final List<AlertId> alertIds;

  @JsonKey(nullable: false)
  final ProxyId alertProviderProxyId;

  DeleteAlertsRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.deviceId,
    @required this.alertIds,
    @required this.alertProviderProxyId,
  }) {
    assertValid();
  }

  @override
  void assertValid() {
    assert(isNotEmpty(requestId));
    assertValidProxyId(proxyId);
    assert(isNotEmpty(deviceId));
    assertNonEmptyProxyObjectList(alertIds);
    assertValidProxyId(alertProviderProxyId);
  }

  @override
  bool isValid() {
    return isNotEmpty(requestId) &&
        isValidProxyId(proxyId) &&
        isNotEmpty(deviceId) &&
        isNonEmptyProxyObjectList(alertIds) &&
        isValidProxyId(alertProviderProxyId);
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
  String get messageType => "in.yagnyam.proxy.messages.alerts.DeleteAlertsRequest";

  @override
  ProxyId getSigner() => proxyId;

  @override
  String toReadableString() {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$DeleteAlertsRequestToJson(this);

  static DeleteAlertsRequest fromJson(Map json) => _$DeleteAlertsRequestFromJson(json);

  static SignedMessage<DeleteAlertsRequest> signedMessageFromJson(Map json) {
    if (json == null) return null;
    SignedMessage<DeleteAlertsRequest> signedMessage = SignedMessage.fromJson<DeleteAlertsRequest>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }
}
