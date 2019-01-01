// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyId _$ProxyIdFromJson(Map<String, dynamic> json) {
  return ProxyId(json['id'] as String, json['sha256Thumbprint'] as String);
}

Map<String, dynamic> _$ProxyIdToJson(ProxyId instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sha256Thumbprint', instance.sha256Thumbprint);
  return val;
}
