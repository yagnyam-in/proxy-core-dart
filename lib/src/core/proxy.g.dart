// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proxy _$ProxyFromJson(Map<String, dynamic> json) {
  return Proxy(
      id: ProxyId.fromJson(json['id'] as Map<String, dynamic>),
      name: json['name'] as String,
      certificate:
          Certificate.fromJson(json['certificate'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProxyToJson(Proxy instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['certificate'] = instance.certificate;
  return val;
}
