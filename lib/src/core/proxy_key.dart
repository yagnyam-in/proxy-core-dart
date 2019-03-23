import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'proxy_id.dart';
import 'proxy_object.dart';
import 'proxy_utils.dart';

part 'proxy_key.g.dart';

@JsonSerializable()
class ProxyKey extends ProxyBaseObject with ProxyUtils {
  @JsonKey(nullable: false)
  final ProxyId id;

  @JsonKey(nullable: true, includeIfNull: false)
  final String name;

  @JsonKey(nullable: false)
  final String localAlias;

  ProxyKey({
    @required this.id,
    this.name,
    @required this.localAlias,
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
    return ProxyKey(id: id ?? this.id, name: name ?? this.name, localAlias: localAlias ?? this.localAlias);
  }

  factory ProxyKey.fromJson(Map<String, dynamic> json) => _$ProxyKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ProxyKeyToJson(this);
}
