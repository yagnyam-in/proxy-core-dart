import 'package:mockito/mockito.dart';
import 'package:proxy_core/services.dart';
import 'package:proxy_core/src/core/proxy.dart';
import "package:test/test.dart";

class MockCryptographyService extends CryptographyService {
  final Map<String, String> getSignaturesResponse;

  final bool verifySignaturesResponse;

  MockCryptographyService({this.getSignaturesResponse, this.verifySignaturesResponse});

  @override
  Future<String> decrypt({Proxy proxy, String encryptionAlgorithm, String cipherText}) {
    throw UnimplementedError("decrypt");
  }

  @override
  Future<String> encrypt({Proxy proxy, String encryptionAlgorithm, String input}) {
    throw UnimplementedError("encrypt");
  }

  @override
  Future<Map<String, String>> getSignatures({Proxy proxy, String input, Set<String> signatureAlgorithms}) {
    return Future.value(getSignaturesResponse);
  }

  @override
  Future<bool> verifySignatures({Proxy proxy, String input, Map<String, String> signatures}) {
    return Future.value(verifySignaturesResponse);
  }
}

class MockProxy extends Mock implements Proxy {}

main() {
  test('CryptographyService.getSignature', () async {
    var proxy = MockProxy();
    var algorithm = "algorithm";
    var cryptographyService = MockCryptographyService(getSignaturesResponse: {algorithm: "sign"});
    expect(await cryptographyService.getSignature(proxy: proxy, input: "input", signatureAlgorithm: algorithm), "sign");
  });

  test('CryptographyService.verifySignature positive', () async {
    var proxy = MockProxy();
    var algorithm = "algorithm";
    var cryptographyService = MockCryptographyService(verifySignaturesResponse: true);
    expect(
        await cryptographyService.verifySignature(
            proxy: proxy, input: "input", signatureAlgorithm: algorithm, signature: "sign"),
        true);
  });

  test('CryptographyService.verifySignature negitive', () async {
    var proxy = MockProxy();
    var algorithm = "algorithm";
    var cryptographyService = MockCryptographyService(verifySignaturesResponse: false);
    expect(
        await cryptographyService.verifySignature(
            proxy: proxy, input: "input", signatureAlgorithm: algorithm, signature: "sign"),
        false);
  });
}
