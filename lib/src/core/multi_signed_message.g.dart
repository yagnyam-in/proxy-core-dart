// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_signed_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSignedMessage<T>
    _$MultiSignedMessageFromJson<T extends MultiSignableMessage>(Map json) {
  return MultiSignedMessage<T>(
      type: json['type'] as String,
      payload: json['payload'] as String,
      signatures: (json['signatures'] as List)
          .map((e) => MultiSignedMessageSignature.fromJson(e as Map))
          .toList());
}

Map<String, dynamic> _$MultiSignedMessageToJson<T extends MultiSignableMessage>(
        MultiSignedMessage<T> instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload,
      'signatures': instance.signatures.map((e) => e.toJson()).toList()
    };
