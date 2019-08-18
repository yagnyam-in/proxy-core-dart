import 'proxy_id.dart';
import 'signable_message.dart';

abstract class SignableAlertMessage extends SignableMessage {

  static const String FIELD_ALERT_TYPE = "alertType";
  static const String FIELD_ALERT_ID = "alertId";
  static const String FIELD_PROXY_UNIVERSE = "proxyUniverse";

  String get alertId;

  String get proxyUniverse;

  List<ProxyId> get receivers;

  /**
   * Minimum required fields for Sending this message as FCM Message so that Client can act on it.
   *
   * @return Map of minimum required fields for this Alert.
   */
  Map<String, String> toFcmMap() =>
      {
        FIELD_ALERT_TYPE: messageType,
        FIELD_ALERT_ID: alertId,
        FIELD_PROXY_UNIVERSE: proxyUniverse,
      };

}
