import 'package:proxy_core/core.dart';
import "package:test/test.dart";

class ProxyUtilsImpl with ProxyUtils {}

class ValidProxyObject extends ProxyBaseObject {
  @override
  bool isValid()  => true;
}

class InValidProxyObject extends ProxyBaseObject {
  @override
  bool isValid()  => false;
}

main() {
  final ProxyUtils proxyUtils = ProxyUtilsImpl();
  test('isNotEmpty', () {
    expect(proxyUtils.isNotEmpty(null), false);
    expect(proxyUtils.isNotEmpty(""), false);
    expect(proxyUtils.isNotEmpty(" "), false);
    expect(proxyUtils.isNotEmpty("     "), false);
    expect(proxyUtils.isNotEmpty("a"), true);
    expect(proxyUtils.isNotEmpty("abc"), true);
    expect(proxyUtils.isNotEmpty(" abc "), true);
  });

  test('isValidProxyObjectList', (){
    expect(proxyUtils.isValidProxyObjectList(null), false);
    expect(proxyUtils.isValidProxyObjectList(<ProxyBaseObject>[]), false);
    expect(proxyUtils.isValidProxyObjectList([InValidProxyObject()]), false);
    expect(proxyUtils.isValidProxyObjectList([InValidProxyObject(), ValidProxyObject()]), false);
    expect(proxyUtils.isValidProxyObjectList([ValidProxyObject()]), true);
    expect(proxyUtils.isValidProxyObjectList([ValidProxyObject(), ValidProxyObject()]), true);
  });

  test('listEquals', () {
    expect(proxyUtils.listEquals(null, null), true);
    expect(proxyUtils.listEquals(null, []), false);
    expect(proxyUtils.listEquals([], null), false);
    expect(proxyUtils.listEquals([], []), true);
    expect(proxyUtils.listEquals([], [1]), false);
    expect(proxyUtils.listEquals([1], []), false);
    expect(proxyUtils.listEquals([1], [1]), true);
    expect(proxyUtils.listEquals(["a", "b"], ["a", "b"]), true);
    expect(proxyUtils.listEquals(["a", "b", "c"], ["a", "b"]), false);
  });
}
