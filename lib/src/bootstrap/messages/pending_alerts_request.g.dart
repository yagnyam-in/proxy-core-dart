// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_alerts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingAlertsRequest _$PendingAlertsRequestFromJson(Map json) {
  return PendingAlertsRequest(
      requestId: json['requestId'] as String,
      proxyId: ProxyId.fromJson(json['proxyId'] as Map),
      deviceId: json['deviceId'] as String,
      fromTime: json['fromTime'] == null
          ? null
          : DateTime.parse(json['fromTime'] as String),
      alertProviderProxyId: json['alertProviderProxyId'] == null
          ? null
          : ProxyId.fromJson(json['alertProviderProxyId'] as Map));
}

Map<String, dynamic> _$PendingAlertsRequestToJson(
    PendingAlertsRequest instance) {
  final val = <String, dynamic>{
    'requestId': instance.requestId,
    'proxyId': instance.proxyId.toJson(),
    'deviceId': instance.deviceId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fromTime', instance.fromTime?.toIso8601String());
  writeNotNull('alertProviderProxyId', instance.alertProviderProxyId?.toJson());
  return val;
}
