import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'proxy_id.dart';
import 'proxy_object.dart';
import 'signable_message.dart';
import 'proxy_utils.dart';
import 'signed_message_signature.dart';

part 'signed_message.g.dart';

@JsonSerializable()
class SignedMessage<T extends SignableMessage> extends ProxyBaseObject with ProxyUtils {
  @JsonKey(ignore: true)
  T message;

  @JsonKey(nullable: false)
  final String type;

  @JsonKey(nullable: false)
  final String payload;

  @JsonKey(nullable: false)
  final ProxyId signedBy;

  @JsonKey(nullable: false)
  final List<SignedMessageSignature> signatures;

  SignedMessage({
    this.message,
    @required this.type,
    @required this.payload,
    @required this.signedBy,
    @required this.signatures,
  })  : assert(isNotEmpty(type)),
        assert(isNotEmpty(payload)),
        assert(signedBy.isValid()),
        assert(isValidProxyObjectList(signatures));

  SignedMessage copy({
    T message,
    String type,
    String payload,
    ProxyId signedBy,
    List<SignedMessageSignature> signatures,
  }) {
    return SignedMessage(
      message: message ?? this.message,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      signedBy: signedBy ?? this.signedBy,
      signatures: signatures ?? this.signatures,
    );
  }

  @override
  bool isValid() {
    return isNotEmpty(type) && isNotEmpty(payload) && signedBy.isValid() && isValidProxyObjectList(signatures);
  }

  Set<ProxyId> validSigners() {
    return message.validSigners();
  }

  bool cabBeSignedBy(ProxyId signerId) {
    return message.cabBeSignedBy(signerId);
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! SignedMessage) {
      return false;
    }
    SignedMessage otherMessage = other as SignedMessage;
    return message == otherMessage.message &&
        type == otherMessage.type &&
        payload == otherMessage.payload &&
        signedBy == otherMessage.signedBy &&
        listEquals(signatures, otherMessage.signatures);
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory SignedMessage.fromJson(Map<String, dynamic> json) => _$SignedMessageFromJson(json);

  Map<String, dynamic> toJson() => _$SignedMessageToJson(this);
}
