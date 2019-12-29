// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyKey _$ProxyKeyFromJson(Map json) {
  return ProxyKey(
    id: ProxyId.fromJson(json['id'] as Map),
    name: json['name'] as String,
    localAlias: json['localAlias'] as String,
    privateKeyEncodedEncrypted: json['privateKeyEncodedEncrypted'] == null
        ? null
        : CipherText.fromJson(json['privateKeyEncodedEncrypted'] as Map),
    privateKeyEncoded: json['privateKeyEncoded'] as String,
    privateKeySha256Thumbprint: json['privateKeySha256Thumbprint'] as String,
    publicKeyEncoded: json['publicKeyEncoded'] as String,
    publicKeySha256Thumbprint: json['publicKeySha256Thumbprint'] as String,
  );
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
  writeNotNull('localAlias', instance.localAlias);
  writeNotNull('privateKeyEncodedEncrypted',
      instance.privateKeyEncodedEncrypted?.toJson());
  writeNotNull('privateKeyEncoded', instance.privateKeyEncoded);
  writeNotNull(
      'privateKeySha256Thumbprint', instance.privateKeySha256Thumbprint);
  writeNotNull('publicKeyEncoded', instance.publicKeyEncoded);
  writeNotNull('publicKeySha256Thumbprint', instance.publicKeySha256Thumbprint);
  return val;
}
