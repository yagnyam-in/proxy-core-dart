import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';
import 'signed_message_signature.dart';

part 'multi_signed_message_signature.g.dart';

@JsonSerializable()
class MultiSignedMessageSignature extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final ProxyId signedBy;

  @JsonKey(nullable: false)
  final List<SignedMessageSignature> signatures;

  MultiSignedMessageSignature({
    @required this.signedBy,
    @required this.signatures,
  }) {
    assertValid();
  }

  @override
  bool isValid() {
    return signedBy != null && signedBy.isValid() && signatures != null && signatures.every((s) => s.isValid());
  }

  @override
  void assertValid() {
    assert(signedBy != null);
    signedBy.assertValid();
    assert(signatures != null);
    assert(signatures.isNotEmpty);
    signatures.forEach((s) => s.assertValid());
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! MultiSignedMessageSignature) {
      return false;
    }
    MultiSignedMessageSignature otherSignature = other as MultiSignedMessageSignature;
    return signedBy == otherSignature.signedBy && listEquals(signatures, otherSignature.signatures);
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory MultiSignedMessageSignature.fromJson(Map json) => _$MultiSignedMessageSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$MultiSignedMessageSignatureToJson(this);
}
