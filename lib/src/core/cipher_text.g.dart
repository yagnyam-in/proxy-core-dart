// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cipher_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CipherText _$CipherTextFromJson(Map json) {
  return CipherText(
    encryptionAlgorithm: json['encryptionAlgorithm'] as String,
    cipherText: json['cipherText'] as String,
    iv: json['iv'] as String,
    hmacAlgorithm: json['hmacAlgorithm'] as String,
    hmac: json['hmac'] as String,
  );
}

Map<String, dynamic> _$CipherTextToJson(CipherText instance) {
  final val = <String, dynamic>{
    'encryptionAlgorithm': instance.encryptionAlgorithm,
    'cipherText': instance.cipherText,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('iv', instance.iv);
  writeNotNull('hmacAlgorithm', instance.hmacAlgorithm);
  writeNotNull('hmac', instance.hmac);
  return val;
}
