import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

/// Alert to be used outside Proxy Network. Within the Network use SignableAlertMessage
class LiteAlert {
  final String alertId;

  final String alertType;

  final String proxyUniverse;

  final ProxyId receiverProxyId;

  LiteAlert({
    @required this.alertId,
    @required this.alertType,
    @required this.proxyUniverse,
    @required this.receiverProxyId,
  });
}
