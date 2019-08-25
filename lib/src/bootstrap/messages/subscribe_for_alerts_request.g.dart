// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_for_alerts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeForAlertsRequest _$SubscribeForAlertsRequestFromJson(Map json) {
  return SubscribeForAlertsRequest(
    requestId: json['requestId'] as String,
    proxyId: ProxyId.fromJson(json['proxyId'] as Map),
    deviceId: json['deviceId'] as String,
    fcmToken: json['fcmToken'] as String,
    alertProviderProxyId: ProxyId.fromJson(json['alertProviderProxyId'] as Map),
  );
}

Map<String, dynamic> _$SubscribeForAlertsRequestToJson(
        SubscribeForAlertsRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'proxyId': instance.proxyId.toJson(),
      'deviceId': instance.deviceId,
      'fcmToken': instance.fcmToken,
      'alertProviderProxyId': instance.alertProviderProxyId.toJson(),
    };
