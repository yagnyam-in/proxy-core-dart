import 'proxy_id.dart';
import 'signable_message.dart';

abstract class SignableAlertMessage extends SignableMessage {

  static const String ALERT_TYPE = "alertType";
  static const String ALERT_ID = "alertId";
  static const String PROXY_UNIVERSE = "proxyUniverse";

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
        ALERT_TYPE: messageType,
        ALERT_ID: alertId,
        PROXY_UNIVERSE: proxyUniverse,
      };

}
