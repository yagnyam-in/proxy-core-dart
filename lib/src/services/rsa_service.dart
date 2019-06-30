import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import "package:pointycastle/export.dart";
import 'package:tuple/tuple.dart';

class RsaService {
  static SecureRandom _getSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = [];
    for (int i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(new KeyParameter(new Uint8List.fromList(seeds)));
    return secureRandom;
  }

  Future<String> sign({
    @required String message,
    @required String algorithm,
    @required RSAPrivateKey privateKey,
  }) async {
    var signer = _signer(algorithm);
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
    return base64Encode(signer.generateSignature(_createUint8ListFromString(message)).bytes);
  }

  Future<bool> verify({
    @required String algorithm,
    @required String signedMessage,
    @required String message,
    @required RSAPublicKey publicKey,
  }) async {
    var signer = _signer(algorithm);
    signer.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    return signer.verifySignature(Uint8List.fromList(message.codeUnits), RSASignature(base64Decode(signedMessage)));
  }

  Uint8List _createUint8ListFromString(String s) {
    var codec = Utf8Codec(allowMalformed: true);
    return Uint8List.fromList(codec.encode(s));
  }

  Future<AsymmetricKeyPair<PublicKey, PrivateKey>> generateRsaKeyPair(
    int keySize,
  ) async {
    ReceivePort receivePort = ReceivePort(); //port for this main isolate to receive messages.
    await Isolate.spawn<Tuple2<int, SendPort>>(_generateRsaKeyPair, Tuple2(keySize, receivePort.sendPort));
    AsymmetricKeyPair<PublicKey, PrivateKey> result = await receivePort.first;
    return result;
  }

  static void _generateRsaKeyPair(Tuple2<int, SendPort> args) {
    SecureRandom secureRandom = _getSecureRandom();
    var rsaParams = new RSAKeyGeneratorParameters(BigInt.from(65537), args.item1, 5);
    var params = new ParametersWithRandom(rsaParams, secureRandom);
    var keyGenerator = new RSAKeyGenerator();
    keyGenerator.init(params);
    args.item2.send(keyGenerator.generateKeyPair());
  }

  RSASigner _signer(String algorithm) {
    if (algorithm == 'SHA256WithRSAEncryption') {
      return RSASigner(SHA256Digest(), "0609608648016503040201");
    }
    throw "Unsupported signing algorithm $algorithm";
  }
}
