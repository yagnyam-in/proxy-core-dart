// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyRequest _$ProxyRequestFromJson(Map<String, dynamic> json) {
  return ProxyRequest(
      id: json['id'] as String,
      alias: json['alias'] as String,
      revocationPassPhraseSha256: json['revocationPassPhraseSha256'] as String,
      requestEncoded: json['requestEncoded'] as String);
}

Map<String, dynamic> _$ProxyRequestToJson(ProxyRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('alias', instance.alias);
  val['revocationPassPhraseSha256'] = instance.revocationPassPhraseSha256;
  val['requestEncoded'] = instance.requestEncoded;
  return val;
}
