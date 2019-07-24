// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceUpdateRequest _$DeviceUpdateRequestFromJson(Map json) {
  return DeviceUpdateRequest(
      requestId: json['requestId'] as String,
      proxyId: ProxyId.fromJson(json['proxyId'] as Map),
      deviceId: json['deviceId'] as String,
      fcmToken: json['fcmToken'] as String,
      deviceName: json['deviceName'] as String);
}

Map<String, dynamic> _$DeviceUpdateRequestToJson(DeviceUpdateRequest instance) {
  final val = <String, dynamic>{
    'requestId': instance.requestId,
    'proxyId': instance.proxyId.toJson(),
    'deviceId': instance.deviceId,
    'fcmToken': instance.fcmToken,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deviceName', instance.deviceName);
  return val;
}
