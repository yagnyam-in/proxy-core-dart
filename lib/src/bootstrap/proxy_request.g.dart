// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyRequest _$ProxyRequestFromJson(Map json) {
  return ProxyRequest(
    id: json['id'] as String,
    revocationPassPhraseHash:
        HashValue.fromJson(json['revocationPassPhraseHash'] as Map),
    requestEncoded: json['requestEncoded'] as String,
  );
}

Map<String, dynamic> _$ProxyRequestToJson(ProxyRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'revocationPassPhraseHash': instance.revocationPassPhraseHash.toJson(),
      'requestEncoded': instance.requestEncoded,
    };
