// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyCreationResponse _$ProxyCreationResponseFromJson(Map json) {
  return ProxyCreationResponse(
      request: ProxyCreationRequest.fromJson(json['request'] as Map),
      proxy: Proxy.fromJson(json['proxy'] as Map));
}

Map<String, dynamic> _$ProxyCreationResponseToJson(
        ProxyCreationResponse instance) =>
    <String, dynamic>{
      'request': instance.request.toJson(),
      'proxy': instance.proxy.toJson()
    };
