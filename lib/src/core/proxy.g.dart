// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proxy _$ProxyFromJson(Map json) {
  return Proxy(
      id: ProxyId.fromJson(json['id'] as Map),
      name: json['name'] as String,
      certificate: Certificate.fromJson(json['certificate'] as Map));
}

Map<String, dynamic> _$ProxyToJson(Proxy instance) {
  final val = <String, dynamic>{
    'id': instance.id.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['certificate'] = instance.certificate.toJson();
  return val;
}
