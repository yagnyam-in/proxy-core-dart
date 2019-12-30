import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/api.dart';
import 'package:proxy_core/core.dart';

import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'proxy_key.g.dart';

@JsonSerializable()
class ProxyKey extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final ProxyId id;

  @JsonKey(nullable: true)
  final String name;

  @JsonKey(nullable: true)
  final String localAlias;

  @JsonKey(nullable: true)
  CipherText privateKeyEncodedEncrypted;

  @JsonKey(nullable: true)
  String privateKeyEncoded;

  @JsonKey(nullable: true)
  final String privateKeySha256Thumbprint;

  @JsonKey(nullable: true)
  final String publicKeyEncoded;

  @JsonKey(nullable: true)
  final String publicKeySha256Thumbprint;

  @JsonKey(ignore: true)
  final PublicKey publicKey;

  @JsonKey(ignore: true)
  PrivateKey privateKey;

  ProxyKey({
    @required this.id,
    this.name,
    this.localAlias,
    this.privateKeyEncodedEncrypted,
    this.privateKeyEncoded,
    this.privateKeySha256Thumbprint,
    this.publicKeyEncoded,
    this.publicKeySha256Thumbprint,
    this.privateKey,
    this.publicKey,
  }) {
    assertValid();
  }

  String toString() {
    return {
      "id": id,
      "name": name,
      "localAlias": localAlias,
    }.toString();
  }

  @override
  bool isValid() {
    return isValidProxyId(id) && isNotEmpty(localAlias);
  }

  @override
  void assertValid() {
    assert(isValidProxyId(id));
    assert(isNotEmpty(localAlias));
  }

  ProxyKey copyWith({ProxyId id, String name, String localAlias}) {
    return ProxyKey(
      id: id ?? this.id,
      name: name ?? this.name,
      localAlias: localAlias ?? this.localAlias,
      privateKeyEncodedEncrypted: privateKeyEncodedEncrypted,
      privateKeyEncoded: privateKeyEncoded,
      privateKeySha256Thumbprint: privateKeySha256Thumbprint,
      publicKeyEncoded: publicKeyEncoded,
      publicKeySha256Thumbprint: publicKeySha256Thumbprint,
      privateKey: privateKey,
      publicKey: publicKey,
    );
  }

  factory ProxyKey.fromJson(Map json) => _$ProxyKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyKeyToJson(this);
}
