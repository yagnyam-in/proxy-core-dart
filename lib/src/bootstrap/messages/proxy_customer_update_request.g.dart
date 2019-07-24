// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_customer_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyCustomerUpdateRequest _$ProxyCustomerUpdateRequestFromJson(Map json) {
  return ProxyCustomerUpdateRequest(
      requestId: json['requestId'] as String,
      proxyId: ProxyId.fromJson(json['proxyId'] as Map),
      name: json['name'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      syncWithContacts: json['syncWithContacts'] as bool);
}

Map<String, dynamic> _$ProxyCustomerUpdateRequestToJson(
    ProxyCustomerUpdateRequest instance) {
  final val = <String, dynamic>{
    'requestId': instance.requestId,
    'proxyId': instance.proxyId.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('emailAddress', instance.emailAddress);
  writeNotNull('phoneNumber', instance.phoneNumber);
  writeNotNull('syncWithContacts', instance.syncWithContacts);
  return val;
}
