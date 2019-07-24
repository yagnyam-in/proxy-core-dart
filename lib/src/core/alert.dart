import 'package:meta/meta.dart';

/// Alert to be used outside Proxy Network. Within the Network use SignableAlertMessage
class Alert {
  final String alertId;

  final String alertType;

  final String proxyUniverse;

  Alert({
    @required this.alertId,
    @required this.alertType,
    @required this.proxyUniverse,
  });
}
