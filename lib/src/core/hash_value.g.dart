// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hash_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HashValue _$HashValueFromJson(Map json) {
  return HashValue(
    algorithm: json['algorithm'] as String,
    iv: json['iv'] as String,
    hash: json['hash'] as String,
  );
}

Map<String, dynamic> _$HashValueToJson(HashValue instance) => <String, dynamic>{
      'algorithm': instance.algorithm,
      'iv': instance.iv,
      'hash': instance.hash,
    };
