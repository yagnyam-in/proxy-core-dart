import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'hash_value.g.dart';

@JsonSerializable()
class HashValue extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final String algorithm;

  @JsonKey(nullable: false)
  final String iv;

  @JsonKey(nullable: false)
  final String hash;

  HashValue({
    @required this.algorithm,
    @required this.iv,
    @required this.hash,
  }) {
    assertValid();
  }

  @override
  bool operator ==(dynamic other) {
    return other != null && other is HashValue && algorithm == other.algorithm && iv == other.iv && hash == other.hash;
  }

  String toString() {
    return toJson().toString();
  }

  @override
  bool isValid() {
    return isNotEmpty(algorithm) && isNotEmpty(iv) && isNotEmpty(hash);
  }

  @override
  void assertValid() {
    assert(isNotEmpty(algorithm));
    assert(isNotEmpty(iv));
    assert(isNotEmpty(hash));
  }

  factory HashValue.fromJson(Map json) => _$HashValueFromJson(json);

  Map<String, dynamic> toJson() => _$HashValueToJson(this);
}
