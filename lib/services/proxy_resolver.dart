import 'package:proxy_core/proxy.dart';
import 'package:proxy_core/proxy_id.dart';

abstract class ProxyResolver {
  Future<List<Proxy>> resolveProxy(ProxyId proxyId);
}
