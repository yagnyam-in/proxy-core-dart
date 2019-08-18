// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_signed_message_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSignedMessageSignature _$MultiSignedMessageSignatureFromJson(Map json) {
  return MultiSignedMessageSignature(
    signedBy: ProxyId.fromJson(json['signedBy'] as Map),
    signatures: (json['signatures'] as List)
        .map((e) => SignedMessageSignature.fromJson(e as Map))
        .toList(),
  );
}

Map<String, dynamic> _$MultiSignedMessageSignatureToJson(
        MultiSignedMessageSignature instance) =>
    <String, dynamic>{
      'signedBy': instance.signedBy.toJson(),
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
    };
