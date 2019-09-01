import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

abstract class ProxyKeyResolver {
  Future<ProxyKey> resolveProxyKey(ProxyId proxyId);
}
