
import 'package:proxy_core/bootstrap.dart';
import 'package:proxy_core/src/bootstrap/services/rsa_helper.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

class PointyCastleProxyKeyFactory extends ProxyKeyFactory {

  @override
  Future<ProxyKey> createProxyKey({String id, String keyGenerationAlgorithm, int keySize}) {
    if (keyGenerationAlgorithm == 'RSA') {
      // return RsaKeyHelper().generateRsaKeyPair(keySize);
    }
    throw "Unsupported algorithm $keyGenerationAlgorithm";
  }

}
