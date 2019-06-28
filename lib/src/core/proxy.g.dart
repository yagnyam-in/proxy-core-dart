// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Proxy _$ProxyFromJson(Map json) {
  return Proxy(
      id: ProxyId.fromJson(json['id'] as Map),
      certificate: Certificate.fromJson(json['certificate'] as Map),
      publicKeyEncoded: json['publicKeyEncoded'] as String,
      publicKeySha256Thumbprint: json['publicKeySha256Thumbprint'] as String,
      name: json['name'] as String);
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
  val['publicKeyEncoded'] = instance.publicKeyEncoded;
  val['publicKeySha256Thumbprint'] = instance.publicKeySha256Thumbprint;
  return val;
}
