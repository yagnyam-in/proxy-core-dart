// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_alerts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingAlertsResponse _$PendingAlertsResponseFromJson(Map json) {
  return PendingAlertsResponse(
    request: SignedMessage.fromJson(json['request'] as Map),
    alerts: PendingAlertsResponse.signedAlertsFromJson(json['alerts'] as List),
    tillTime: json['tillTime'] == null
        ? null
        : DateTime.parse(json['tillTime'] as String),
  );
}

Map<String, dynamic> _$PendingAlertsResponseToJson(
    PendingAlertsResponse instance) {
  final val = <String, dynamic>{
    'request': instance.request.toJson(),
    'alerts': instance.alerts.map((e) => e.toJson()).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tillTime', instance.tillTime?.toIso8601String());
  return val;
}
