import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'cipher_text.g.dart';

@JsonSerializable()
class CipherText extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String encryptionAlgorithm;

  @JsonKey(nullable: false)
  final String cipherText;

  @JsonKey(nullable: true)
  final String iv;

  @JsonKey(nullable: true)
  final String hmacAlgorithm;

  @JsonKey(nullable: true)
  final String hmac;

  CipherText({
    @required this.encryptionAlgorithm,
    @required this.cipherText,
    this.iv,
    this.hmacAlgorithm,
    this.hmac,
  }) {
    assertValid();
  }

  @override
  bool operator ==(dynamic other) {
    return other != null &&
        other is CipherText &&
        encryptionAlgorithm == other.encryptionAlgorithm &&
        cipherText == other.cipherText &&
        iv == other.iv &&
        hmacAlgorithm == other.hmacAlgorithm &&
        hmac == other.hmac;
  }

  String toString() {
    return toJson().toString();
  }

  @override
  bool isValid() {
    return isNotEmpty(encryptionAlgorithm) && isNotEmpty(cipherText);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(encryptionAlgorithm));
    assert(isNotEmpty(cipherText));
  }

  factory CipherText.fromJson(Map json) => _$CipherTextFromJson(json);

  Map<String, dynamic> toJson() => _$CipherTextToJson(this);
}
