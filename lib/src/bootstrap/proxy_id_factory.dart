import 'package:uuid/uuid.dart';

class ProxyIdFactory {
  final RegExp _alpha = new RegExp(r'^[a-zA-Z]+$');
  final Uuid uuid;

  ProxyIdFactory(this.uuid);

  factory ProxyIdFactory.instance() => ProxyIdFactory(Uuid());

  String proxyId() {
    String id;
    do {
      id = uuid.v4().substring(19);
    } while (!_alpha.hasMatch(id[0]));
    return id;
  }
}
