import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';
import 'package:quiver/cache.dart';

import 'proxy_resolver.dart';

class CachedProxyResolver implements ProxyResolver {
  final ProxyResolver proxyResolver;

  final Cache<ProxyId, Proxy> _cache;

  final int maximumSize;

  CachedProxyResolver({@required this.proxyResolver, int maximumSize = 16})
      : _cache = MapCache<ProxyId, Proxy>(),
        maximumSize = maximumSize {
    assert(proxyResolver != null);
  }

  @override
  Future<Proxy> resolveProxy(ProxyId proxyId) async {
    return _cache.get(proxyId, ifAbsent: (id) => proxyResolver.resolveProxy(id));
  }
}
