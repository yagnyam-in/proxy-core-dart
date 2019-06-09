import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:proxy_core/src/core/message_builder.dart';
import 'package:proxy_core/src/core/proxy_id.dart';
import 'package:proxy_core/src/core/proxy_utils.dart';
import 'package:proxy_core/src/core/signable_message.dart';
import 'package:proxy_core/src/core/signed_message.dart';

part 'proxy_customer_update_request.g.dart';

@JsonSerializable()
class ProxyCustomerUpdateRequest extends SignableMessage with ProxyUtils {
  @JsonKey(nullable: false)
  final String requestId;

  @JsonKey(nullable: false)
  final ProxyId proxyId;

  @JsonKey(nullable: true)
  final String gcmToken;

  @JsonKey(nullable: true)
  final String name;

  @JsonKey(nullable: true)
  final String emailAddress;

  @JsonKey(nullable: true)
  final String phoneNumber;

  @JsonKey(nullable: true)
  final bool syncWithContacts;

  ProxyCustomerUpdateRequest({
    @required this.requestId,
    @required this.proxyId,
    this.gcmToken,
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.syncWithContacts,
  });

  @override
  void assertValid() {
    assert(requestId != null);
    assert(isNotEmpty(requestId));
    assert(proxyId != null);
    proxyId.assertValid();
  }

  @override
  bool isValid() {
    return isNotEmpty(requestId) && isValidProxyId(proxyId);
  }

  @override
  List<SignedMessage<SignableMessage>> getChildMessages() {
    return [];
  }

  @override
  String get messageType => "in.yagnyam.proxy.messages.registration.ProxyCustomerUpdateRequest";

  @override
  ProxyId getSigner() => proxyId;

  @override
  String toReadableString() {
    return null;
  }

  @override
  Map<String, dynamic> toJson() => _$ProxyCustomerUpdateRequestToJson(this);

  static ProxyCustomerUpdateRequest fromJson(Map json) => _$ProxyCustomerUpdateRequestFromJson(json);

  static SignedMessage<ProxyCustomerUpdateRequest> signedMessageFromJson(Map json) {
    SignedMessage<ProxyCustomerUpdateRequest> signedMessage = SignedMessage.fromJson<ProxyCustomerUpdateRequest>(json);
    signedMessage.message = MessageBuilder.instance().buildSignableMessage(signedMessage.payload, fromJson);
    return signedMessage;
  }
}
