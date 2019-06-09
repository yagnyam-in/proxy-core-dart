// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Certificates _$CertificatesFromJson(Map json) {
  return Certificates((json['certificates'] as List)
      .map((e) => Certificate.fromJson(e as Map))
      .toList());
}

Map<String, dynamic> _$CertificatesToJson(Certificates instance) =>
    <String, dynamic>{
      'certificates': instance.certificates.map((e) => e.toJson()).toList()
    };
