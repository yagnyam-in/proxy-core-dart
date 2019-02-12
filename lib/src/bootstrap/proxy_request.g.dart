// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyRequest _$ProxyRequestFromJson(Map<String, dynamic> json) {
  return ProxyRequest(
      id: json['id'] as String,
      revocationPassPhraseSha256: json['revocationPassPhraseSha256'] as String,
      requestEncoded: json['requestEncoded'] as String);
}

Map<String, dynamic> _$ProxyRequestToJson(ProxyRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'revocationPassPhraseSha256': instance.revocationPassPhraseSha256,
      'requestEncoded': instance.requestEncoded
    };
