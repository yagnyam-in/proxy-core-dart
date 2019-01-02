
import 'proxy_id.dart';
import 'signable_message.dart';

abstract class SignableAlertMessage extends SignableMessage {

  String get alertId;

  List<ProxyId> get receivers;
}
