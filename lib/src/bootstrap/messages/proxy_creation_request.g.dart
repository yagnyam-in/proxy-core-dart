// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_creation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyCreationRequest _$ProxyCreationRequestFromJson(Map json) {
  return ProxyCreationRequest(
      requestId: json['requestId'] as String,
      proxyId: json['proxyId'] as String,
      revocationPassPhraseSha256: json['revocationPassPhraseSha256'] as String,
      certificateRequestEncoded: json['certificateRequestEncoded'] as String);
}

Map<String, dynamic> _$ProxyCreationRequestToJson(
        ProxyCreationRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'proxyId': instance.proxyId,
      'revocationPassPhraseSha256': instance.revocationPassPhraseSha256,
      'certificateRequestEncoded': instance.certificateRequestEncoded
    };
