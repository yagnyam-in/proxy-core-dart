import 'package:proxy_core/core.dart';

abstract class ProxyResolver {
  Future<List<Proxy>> resolveProxy(ProxyId proxyId);
}
