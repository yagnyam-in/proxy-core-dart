// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_chain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateChain _$CertificateChainFromJson(Map json) {
  return CertificateChain(
      certificateSerial: json['certificateSerial'] as String,
      certificateId: json['certificateId'] as String,
      certificates: (json['certificates'] as List)
          .map((e) => Certificate.fromJson(e as Map))
          .toList());
}

Map<String, dynamic> _$CertificateChainToJson(CertificateChain instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('certificateSerial', instance.certificateSerial);
  writeNotNull('certificateId', instance.certificateId);
  val['certificates'] = instance.certificates.map((e) => e.toJson()).toList();
  return val;
}
