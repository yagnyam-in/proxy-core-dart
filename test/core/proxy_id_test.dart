library proxy.core;

import 'dart:convert';

import 'package:proxy_core/src/core/proxy_id.dart';
import "package:test/test.dart";

main() {
  String _encode(ProxyId proxyId) {
    return jsonEncode(proxyId);
  }

  ProxyId _decode(String jsonString) {
    Map userMap = jsonDecode(jsonString);
    return ProxyId.fromJson(userMap);
  }

  test('proxy id without sha256Thumbprint', () {
    ProxyId proxyId = ProxyId("id");
    expect(proxyId.uniqueId, "id");
    expect(proxyId.isValid(), true);
    expect(proxyId.canSignOnBehalfOf(proxyId), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId.any()), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId("id", "sha256")), false);
    expect(_encode(proxyId), """{"id":"id"}""");
    expect(_decode("""{"id":"id"}"""), proxyId);
  });

  test('proxy id with sha256Thumbprint', () {
    ProxyId proxyId = ProxyId("id", "sha256");
    expect(proxyId.uniqueId, "id#sha256");
    expect(proxyId.isValid(), true);
    expect(proxyId.canSignOnBehalfOf(proxyId), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId.any()), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId("id")), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId("id", "anotherSha256")), false);
    expect(_encode(proxyId), """{"id":"id","sha256Thumbprint":"sha256"}""");
    expect(_decode("""{"id":"id","sha256Thumbprint":"sha256"}"""), proxyId);
  });

  test('any proxy id', () {
    ProxyId proxyId = ProxyId.any();
    expect(proxyId.uniqueId, "any");
    expect(proxyId.isValid(), true);
    expect(proxyId.canSignOnBehalfOf(proxyId), true);
    expect(proxyId.canSignOnBehalfOf(ProxyId("id")), false);
    expect(proxyId.canSignOnBehalfOf(ProxyId("id", "anotherSha256")), false);
    expect(_encode(proxyId), """{"id":"any"}""");
    expect(_decode("""{"id":"any"}"""), proxyId);
  });
}
