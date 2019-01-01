
import 'package:proxy_core/proxy_id.dart';
import 'package:proxy_core/signable_message.dart';

abstract class SignableAlertMessage extends SignableMessage {

  String get alertId;

  List<ProxyId> get receivers;
}