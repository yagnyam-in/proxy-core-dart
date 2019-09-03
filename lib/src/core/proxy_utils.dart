import 'proxy_id.dart';
import 'proxy_object.dart';

mixin ProxyUtils {
  bool isEmpty(String value) {
    return value == null || value.trim().isEmpty;
  }

  bool isNotEmpty(String value) {
    return value != null && value.trim().isNotEmpty;
  }

  void assertNotEmpty(String value) {
    assert(value != null);
    assert(value.isNotEmpty);
  }

  bool isValidProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    return values != null && values.every((e) => e.isValid());
  }

  bool isNonEmptyProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    return isValidProxyObjectList(values) && values.isNotEmpty;
  }

  void assertValidProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    assert(values != null);
    values.forEach((e) => e.assertValid());
  }

  void assertNonEmptyProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    assertValidProxyObjectList(values);
    assert(values.isNotEmpty);
  }

  bool isValidDateTime(DateTime dateTime) {
    return dateTime != null;
  }

  void assertValidDateTime(DateTime dateTime) {
    assert(dateTime != null);
  }

  bool isValidProxyObject(ProxyBaseObject proxyObject) {
    return proxyObject != null && proxyObject.isValid();
  }

  void assertValidProxyObject(ProxyBaseObject proxyObject) {
    assert(proxyObject != null);
    proxyObject.assertValid();
  }

  bool isValidProxyId(ProxyId proxyId) {
    return proxyId != null && proxyId.isValid();
  }

  bool assertValidProxyId(ProxyId proxyId) {
    assert(proxyId != null);
    proxyId.assertValid();
  }

  bool listEquals<T>(List<T> aList, List<T> bList) {
    if (aList == null && bList == null) {
      return true;
    }
    if (aList == null || bList == null) {
      return false;
    }
    if (aList.isEmpty && bList.isEmpty) {
      return true;
    }
    if (aList.length != bList.length) {
      return false;
    }
    for (var i = 0; i < aList.length; i++) {
      if (aList.elementAt(i) != bList.elementAt(i)) {
        return false;
      }
    }
    return true;
  }
}
