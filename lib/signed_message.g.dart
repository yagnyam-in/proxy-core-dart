// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedMessage<T> _$SignedMessageFromJson<T extends SignableMessage>(
    Map<String, dynamic> json) {
  return SignedMessage<T>(
      type: json['type'] as String,
      payload: json['payload'] as String,
      signedBy: ProxyId.fromJson(json['signedBy'] as Map<String, dynamic>),
      signatures: (json['signatures'] as List)
          .map(
              (e) => SignedMessageSignature.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$SignedMessageToJson<T extends SignableMessage>(
        SignedMessage<T> instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload,
      'signedBy': instance.signedBy,
      'signatures': instance.signatures
    };
