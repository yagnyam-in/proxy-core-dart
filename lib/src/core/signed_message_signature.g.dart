// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_message_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedMessageSignature _$SignedMessageSignatureFromJson(Map json) {
  return SignedMessageSignature(
      json['algorithm'] as String, json['value'] as String);
}

Map<String, dynamic> _$SignedMessageSignatureToJson(
        SignedMessageSignature instance) =>
    <String, dynamic>{'algorithm': instance.algorithm, 'value': instance.value};
