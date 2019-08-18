// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificate _$CertificateFromJson(Map json) {
  return Certificate(
    serialNumber: json['serialNumber'] as String,
    owner: json['owner'] as String,
    sha256Thumbprint: json['sha256Thumbprint'] as String,
    alias: json['alias'] as String,
    subject: json['subject'] as String,
    validFrom: DateTime.parse(json['validFrom'] as String),
    validTill: DateTime.parse(json['validTill'] as String),
    certificateEncoded: json['certificateEncoded'] as String,
    publicKeyEncoded: json['publicKeyEncoded'] as String,
    publicKeySha256Thumbprint: json['publicKeySha256Thumbprint'] as String,
  );
}

Map<String, dynamic> _$CertificateToJson(Certificate instance) {
  final val = <String, dynamic>{
    'serialNumber': instance.serialNumber,
    'owner': instance.owner,
    'sha256Thumbprint': instance.sha256Thumbprint,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('alias', instance.alias);
  val['subject'] = instance.subject;
  val['validFrom'] = instance.validFrom.toIso8601String();
  val['validTill'] = instance.validTill.toIso8601String();
  val['certificateEncoded'] = instance.certificateEncoded;
  val['publicKeyEncoded'] = instance.publicKeyEncoded;
  val['publicKeySha256Thumbprint'] = instance.publicKeySha256Thumbprint;
  return val;
}
