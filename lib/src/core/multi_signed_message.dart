import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'multi_signable_message.dart';
import 'multi_signed_message_signature.dart';
import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'multi_signed_message.g.dart';

@JsonSerializable()
class MultiSignedMessage<T extends MultiSignableMessage> extends ProxyBaseObject with ProxyUtils {
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
  final List<MultiSignedMessageSignature> signatures;

  MultiSignedMessage({
    T message,
    @required this.type,
    @required this.payload,
    @required this.signatures,
  }) : _message = message {
    assertValid();
  }

  MultiSignedMessage copy({
    T message,
    String type,
    String payload,
    List<MultiSignedMessageSignature> signatures,
  }) {
    return MultiSignedMessage(
      message: message ?? this._message,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      signatures: signatures ?? this.signatures,
    );
  }

  MultiSignedMessage addSignature(MultiSignedMessageSignature signature) {
    return MultiSignedMessage(
      message: this._message,
      type: this.type,
      payload: this.payload,
      signatures: [...this.signatures, signature],
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

  bool hasSufficientSignatures() {
    final signers = signatures.map((s) => s.signedBy).toSet();
    return _message.hasSufficientSignatures(signers);
  }

  @JsonKey(ignore: true)
  set verified(bool verified) => _verified = verified;

  @override
  bool isValid() {
    return isNotEmpty(type) &&
        (_message == null || isNotEmpty(payload)) &&
        (_message == null || _message.isValid()) &&
        (signatures != null && signatures.every((s) => s.isValid()));
  }

  @override
  void assertValid() {
    assert(isNotEmpty(type));
    assert(_message == null || isNotEmpty(payload));
    assert(_message == null || _message.isValid());
    assert(signatures != null);
    signatures.forEach((s) => s.assertValid());
  }

  Set<ProxyId> validSigners() {
    return _message.getValidSigners();
  }

  bool cabBeSignedBy(ProxyId signerId) {
    return _message.cabBeSignedBy(signerId);
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! MultiSignedMessage) {
      return false;
    }
    MultiSignedMessage otherMessage = other as MultiSignedMessage;
    return _message == otherMessage._message &&
        type == otherMessage.type &&
        payload == otherMessage.payload &&
        listEquals(signatures, otherMessage.signatures);
  }

  @override
  String toString() {
    return toJson().toString();
  }

  static MultiSignedMessage<X> fromJson<X extends MultiSignableMessage>(Map json) =>
      _$MultiSignedMessageFromJson<X>(json);

  Map<String, dynamic> toJson() {
    assert(isNotEmpty(payload));
    return _$MultiSignedMessageToJson(this);
  }
}
