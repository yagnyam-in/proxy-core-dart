import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/src/core/message_builder.dart';
import 'package:proxy_core/src/core/proxy_id.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

part 'device_update_request.g.dart';

@JsonSerializable()
class DeviceUpdateRequest extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final String requestId;

  @JsonKey(nullable: false)
  final ProxyId proxyId;

  @JsonKey(nullable: false)
  final String deviceId;

  @JsonKey(nullable: false)
  final String fcmToken;

  @JsonKey(nullable: true)
  final String deviceName;

  DeviceUpdateRequest({
    @required this.requestId,
    @required this.proxyId,
    @required this.deviceId,
    @required this.fcmToken,
    this.deviceName,
  });

  @override
  void assertValid() {
    assert(requestId != null);
    assert(isNotEmpty(requestId));
    assert(isNotEmpty(deviceId));
    assert(isNotEmpty(fcmToken));
    assert(proxyId != null);
    proxyId.assertValid();
  }

  @override
  bool isValid() {
    return isNotEmpty(requestId) && isValidProxyId(proxyId) && isNotEmpty(deviceId) && isNotEmpty(fcmToken);
  }

  @override
  List<SignedMessage<SignableMessage>> getChildMessages() {
    return [];
  }

  @override
  String get messageType => "in.yagnyam.proxy.messages.registration.DeviceUpdateRequest";

  @override
  ProxyId getSigner() => proxyId;

  @override
  String toReadableString() {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$DeviceUpdateRequestToJson(this);

  static DeviceUpdateRequest fromJson(Map json) => _$DeviceUpdateRequestFromJson(json);

  static SignedMessage<DeviceUpdateRequest> signedMessageFromJson(Map json) {
    SignedMessage<DeviceUpdateRequest> signedMessage = SignedMessage.fromJson<DeviceUpdateRequest>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }
}
