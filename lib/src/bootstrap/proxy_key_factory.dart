import 'package:proxy_core/src/core/proxy_key.dart';

abstract class ProxyKeyFactory {
  Future<ProxyKey> createProxyKey({
    String id,
    String keyGenerationAlgorithm,
    int keySize,
  });
}
