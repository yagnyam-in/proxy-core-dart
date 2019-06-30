import 'package:meta/meta.dart';
import 'package:proxy_core/services.dart';
import 'package:proxy_core/src/services/pem_service.dart';
import 'package:proxy_core/src/services/rsa_service.dart';
import 'package:proxy_core/src/core/proxy.dart';
import 'package:proxy_core/src/core/proxy_key.dart';

class PointyCastleCryptographyService extends CryptographyService {
  final RsaService _rsaKeyHelper = RsaService();
  final PemService _pemService = PemService();

  @override
  Future<String> decrypt({
    ProxyKey proxyKey,
    String encryptionAlgorithm,
    String cipherText,
  }) {
    throw UnimplementedError("CryptographyService.decrypt is not yet implemented");
  }

  @override
  Future<String> encrypt({
    Proxy proxy,
    String encryptionAlgorithm,
    String input,
  }) {
    throw UnimplementedError("CryptographyService.encrypt is not yet implemented");
  }

  @override
  Future<Map<String, String>> getSignatures({
    ProxyKey proxyKey,
    String input,
    Set<String> signatureAlgorithms,
  }) async {
    Map<String, String> signatures = {};
    signatureAlgorithms.forEach(
      (signatureAlgorithm) async => signatures[signatureAlgorithm] = await getSignature(
            proxyKey: proxyKey,
            input: input,
            signatureAlgorithm: signatureAlgorithm,
          ),
    );
    return signatures;
  }

  @override
  Future<bool> verifySignatures({
    Proxy proxy,
    String input,
    Map<String, String> signatures,
  }) async {
    bool valid = true;
    signatures.forEach((signatureAlgorithm, signature) async {
      valid = valid &&
          await verifySignature(
            proxy: proxy,
            input: input,
            signatureAlgorithm: signatureAlgorithm,
            signature: signature,
          );
    });
    return valid;
  }

  @override
  Future<bool> verifySignature({
    @required Proxy proxy,
    @required String input,
    @required String signatureAlgorithm,
    @required String signature,
  }) {
    if (proxy.publicKey == null) {
      proxy.publicKey = _pemService.decodePublicKey(proxy.publicKeyEncoded);
    }
    return _rsaKeyHelper.verify(
      publicKey: proxy.publicKey,
      signedMessage: signature,
      algorithm: signatureAlgorithm,
      message: input,
    );
  }

  @override
  Future<String> getSignature({
    @required ProxyKey proxyKey,
    @required String input,
    @required String signatureAlgorithm,
  }) async {
    if (proxyKey.privateKey == null) {
      proxyKey.privateKey = _pemService.decodePrivateKey(proxyKey.privateKeyEncoded);
    }
    return _rsaKeyHelper.sign(
      privateKey: proxyKey.privateKey,
      algorithm: signatureAlgorithm,
      message: input,
    );
  }
}
