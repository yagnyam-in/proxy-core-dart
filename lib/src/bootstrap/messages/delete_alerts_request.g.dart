// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_alerts_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertId _$AlertIdFromJson(Map json) {
  return AlertId(
    proxyUniverse: json['proxyUniverse'] as String,
    alertId: json['alertId'] as String,
    alertType: json['alertType'] as String,
  );
}

Map<String, dynamic> _$AlertIdToJson(AlertId instance) => <String, dynamic>{
      'proxyUniverse': instance.proxyUniverse,
      'alertId': instance.alertId,
      'alertType': instance.alertType,
    };

DeleteAlertsRequest _$DeleteAlertsRequestFromJson(Map json) {
  return DeleteAlertsRequest(
    requestId: json['requestId'] as String,
    proxyId: ProxyId.fromJson(json['proxyId'] as Map),
    deviceId: json['deviceId'] as String,
    alertIds: (json['alertIds'] as List)
        .map((e) => AlertId.fromJson(e as Map))
        .toList(),
    alertProviderProxyId: json['alertProviderProxyId'] == null
        ? null
        : ProxyId.fromJson(json['alertProviderProxyId'] as Map),
  );
}

Map<String, dynamic> _$DeleteAlertsRequestToJson(DeleteAlertsRequest instance) {
  final val = <String, dynamic>{
    'requestId': instance.requestId,
    'proxyId': instance.proxyId.toJson(),
    'deviceId': instance.deviceId,
    'alertIds': instance.alertIds.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('alertProviderProxyId', instance.alertProviderProxyId?.toJson());
  return val;
}
