// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proxy_customer_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProxyCustomerUpdateRequest _$ProxyCustomerUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return ProxyCustomerUpdateRequest(
      requestId: json['requestId'] as String,
      proxyId: ProxyId.fromJson(json['proxyId'] as Map<String, dynamic>),
      gcmToken: json['gcmToken'] as String,
      name: json['name'] as String,
      emailAddress: json['emailAddress'] as String,
      phoneNumber: json['phoneNumber'] as String,
      syncWithContacts: json['syncWithContacts'] as bool);
}

Map<String, dynamic> _$ProxyCustomerUpdateRequestToJson(
        ProxyCustomerUpdateRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'proxyId': instance.proxyId,
      'gcmToken': instance.gcmToken,
      'name': instance.name,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'syncWithContacts': instance.syncWithContacts
    };
