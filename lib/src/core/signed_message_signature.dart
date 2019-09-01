import 'package:json_annotation/json_annotation.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';
part 'signed_message_signature.g.dart';

@JsonSerializable()
class SignedMessageSignature extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String algorithm;

  @JsonKey(nullable: false)
  final String value;

  SignedMessageSignature(this.algorithm, this.value) {
    assertValid();
  }

  @override
  bool isValid() {
    return isNotEmpty(algorithm) && isNotEmpty(value);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(algorithm));
    assert(isNotEmpty(value));
  }

  @override
  bool operator ==(dynamic other) {
    if (other == null || other is! SignedMessageSignature) {
      return false;
    }
    SignedMessageSignature otherSignature = other as SignedMessageSignature;
    return algorithm == otherSignature.algorithm && value == otherSignature.value;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  factory SignedMessageSignature.fromJson(Map json) => _$SignedMessageSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignedMessageSignatureToJson(this);
}
