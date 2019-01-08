// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyCreationResponse _$ProxyCreationResponseFromJson(
    Map<String, dynamic> json) {
  return ProxyCreationResponse(
      request: ProxyCreationRequest.fromJson(
          json['request'] as Map<String, dynamic>),
      proxy: Proxy.fromJson(json['proxy'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProxyCreationResponseToJson(
        ProxyCreationResponse instance) =>
    <String, dynamic>{'request': instance.request, 'proxy': instance.proxy};
