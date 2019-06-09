import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';
import 'signable_message.dart';
import 'signed_message_signature.dart';

part 'signed_message.g.dart';

@JsonSerializable()
class SignedMessage<T extends SignableMessage> extends ProxyBaseObject with ProxyUtils {
  /// Underlying Message as Runtime Object
  ///
  /// Make sure verified is set to false upon this variable mutation
  @JsonKey(ignore: true)
  T _message;

  /// Is this message already Verified ??
  ///
  /// Verification is costly, not verified if already verified
  @JsonKey(ignore: true)
  bool _verified = false;

  @JsonKey(nullable: false)
  final String type;

  @JsonKey(nullable: false)
  final String payload;

  @JsonKey(nullable: false)
  final ProxyId signedBy;

  @JsonKey(nullable: false)
  final List<SignedMessageSignature> signatures;

  SignedMessage({
    T message,
    @required this.type,
    @required this.payload,
    @required this.signedBy,
    @required this.signatures,
  }) : _message = message {
    assertValid();
  }

  SignedMessage copy({
    T message,
    String type,
    String payload,
    ProxyId signedBy,
    List<SignedMessageSignature> signatures,
  }) {
    return SignedMessage(
      message: message ?? this._message,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      signedBy: signedBy ?? this.signedBy,
      signatures: signatures ?? this.signatures,
    );
  }

  @JsonKey(ignore: true)
  T get message => _message;

  @JsonKey(ignore: true)
  set message(T message) {
    _verified = false;
    // Make sure all non final members are specified here
    _message = message;
  }

  @JsonKey(ignore: true)
  bool get verified => _verified;

  @JsonKey(ignore: true)
  set verified(bool verified) => _verified = verified;

  @override
  bool isValid() {
    return isNotEmpty(type) &&
        (_message == null || isNotEmpty(payload)) &&
        (_message == null || _message.isValid()) &&
        signedBy.isValid() &&
        isValidProxyObjectList(signatures);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(type));
    assert(_message == null || isNotEmpty(payload));
    assert(_message == null || _message.isValid());
    signedBy.assertValid();
    assertValidProxyObjectList(signatures);
  }

  Set<ProxyId> validSigners() {
    return _message.getValidSigners();
  }

  bool cabBeSignedBy(ProxyId signerId) {
    return _message.cabBeSignedBy(signerId);
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! SignedMessage) {
      return false;
    }
    SignedMessage otherMessage = other as SignedMessage;
    return _message == otherMessage._message &&
        type == otherMessage.type &&
        payload == otherMessage.payload &&
        signedBy == otherMessage.signedBy &&
        listEquals(signatures, otherMessage.signatures);
  }

  @override
  String toString() {
    return toJson().toString();
  }

  static SignedMessage<X> fromJson<X extends SignableMessage>(Map json) =>
      _$SignedMessageFromJson<X>(json);

  Map<String, dynamic> toJson() {
    assert(isNotEmpty(payload));
    return _$SignedMessageToJson(this);
  }
}
