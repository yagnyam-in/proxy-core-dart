import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/services/proxy_key_resolver.dart';

import 'proxy_request.dart';

/// Proxy Key Store
abstract class ProxyKeyStore extends ProxyKeyResolver with ProxyUtils {
  Future<void> saveProxy({ProxyKey proxyKey, Proxy proxy});
}
