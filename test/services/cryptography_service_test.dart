import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:proxy_core/services.dart';
import 'package:proxy_core/src/core/proxy.dart';
import 'package:proxy_core/src/core/proxy_key.dart';
import "package:test/test.dart";

class MockCryptographyService extends CryptographyService {
  final Map<String, String> getSignaturesResponse;

  final bool verifySignaturesResponse;

  MockCryptographyService({this.getSignaturesResponse, this.verifySignaturesResponse});

  @override
  Future<String> decrypt({ProxyKey proxyKey, String encryptionAlgorithm, String cipherText}) {
    throw UnimplementedError("decrypt");
  }

  @override
  Future<String> encrypt({Proxy proxy, String encryptionAlgorithm, String input}) {
    throw UnimplementedError("encrypt");
  }

  @override
  Future<Map<String, String>> getSignatures({ProxyKey proxyKey, String input, Set<String> signatureAlgorithms}) {
    return Future.value(getSignaturesResponse);
  }

  @override
  Future<bool> verifySignatures({Proxy proxy, String input, Map<String, String> signatures}) {
    return Future.value(verifySignaturesResponse);
  }
}

class MockProxy extends Mock implements Proxy {}

class MockProxyKey extends Mock implements ProxyKey {}

main() {
  test('CryptographyService.getSignature', () async {
    var proxyKey = MockProxyKey();
    var algorithm = "algorithm";
    var cryptographyService = MockCryptographyService(getSignaturesResponse: {algorithm: "sign"});
    expect(await cryptographyService.getSignature(proxyKey: proxyKey, input: "input", signatureAlgorithm: algorithm),
        "sign");
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

  test('CryptographyService.getHash', () async {
    var cryptographyService = MockCryptographyService(verifySignaturesResponse: false);
    expect(
      await cryptographyService.getHash(input: "Hello World!!", hashAlgorithm: "SHA256"),
      "CWwKcsMfmi1lEm2OikAaKrLy4h0KKCpv/mZCu+9l/9k=",
    );
  });


  test('CryptographyService.getHmac', () async {
    var cryptographyService = MockCryptographyService(verifySignaturesResponse: false);
    expect(
      await cryptographyService.getHmac(input: "Hello World!!", hmacAlgorithm: "HmacSHA256", key: "Secret Key"),
      "greqDRX0BW75FowfIKLB6xOmTTsrU8zE+4emBPOlTHw=",
    );
  });
}
