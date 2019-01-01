import 'package:json_annotation/json_annotation.dart';
import 'package:proxy_core/proxy_object.dart';
import 'package:proxy_core/proxy_utils.dart';
part 'signed_message_signature.g.dart';

@JsonSerializable()
class SignedMessageSignature extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String algorithm;

  @JsonKey(nullable: false)
  final String value;

  SignedMessageSignature(this.algorithm, this.value)
      : assert(isNotEmpty(algorithm)),
        assert(isNotEmpty(value));

  @override
  bool isValid() {
    return isNotEmpty(algorithm) && isNotEmpty(value);
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

  factory SignedMessageSignature.fromJson(Map<String, dynamic> json) => _$SignedMessageSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignedMessageSignatureToJson(this);

}
