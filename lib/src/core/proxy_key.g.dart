// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyKey _$ProxyKeyFromJson(Map json) {
  return ProxyKey(
      id: ProxyId.fromJson(json['id'] as Map),
      name: json['name'] as String,
      localAlias: json['localAlias'] as String);
}

Map<String, dynamic> _$ProxyKeyToJson(ProxyKey instance) {
  final val = <String, dynamic>{
    'id': instance.id.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['localAlias'] = instance.localAlias;
  return val;
}
