import 'package:meta/meta.dart';
import 'package:proxy_core/bootstrap.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/src/services/pem_service.dart';
import 'package:proxy_core/src/services/rsa_service.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

class PointyCastleProxyKeyFactory extends ProxyKeyFactory {
  final RsaService _rsaKeyHelper = RsaService();

  final PemService _pemService = PemService();

  @override
  Future<ProxyKey> createProxyKey({
    @required String id,
    @required String keyGenerationAlgorithm,
    @required int keySize,
  }) {
    if (keyGenerationAlgorithm == 'RSA') {
      return createRsaProxyKey(id: id, keySize: keySize);
    }
    throw ArgumentError("Unsupported key generation algorithm $keyGenerationAlgorithm");
  }

  Future<ProxyKey> createRsaProxyKey({
    @required String id,
    @required int keySize,
  }) async {
    var keyPair = await _rsaKeyHelper.generateRsaKeyPair(keySize);
    return ProxyKey(
      id: ProxyId(id),
      localAlias: id,
      privateKeyEncoded: _pemService.encodePrivateKey(keyPair.privateKey),
      publicKeyEncoded: _pemService.encodePublicKey(keyPair.publicKey),
      privateKey: keyPair.privateKey,
      publicKey: keyPair.publicKey,
    );
  }
}
