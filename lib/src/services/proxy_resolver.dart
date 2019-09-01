import 'package:proxy_core/core.dart';

abstract class ProxyResolver {
  Future<Proxy> resolveProxy(ProxyId proxyId);
}
