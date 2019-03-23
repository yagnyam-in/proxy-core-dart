import 'proxy_object.dart';
import 'proxy_id.dart';

mixin ProxyUtils {
  bool isNotEmpty(String value) {
    return value != null && value.trim().isNotEmpty;
  }

  bool isValidProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    return values != null && values.isNotEmpty && values.every((e) => e.isValid());
  }

  void assertValidProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    assert(values != null);
    assert(values.isNotEmpty);
    values.forEach((e) => e.assertValid());
  }


  bool isValidDateTime(DateTime dateTime) {
    return dateTime != null;
  }

  bool isValidProxyObject(ProxyBaseObject proxyObject) {
    return proxyObject != null && proxyObject.isValid();
  }

  bool isValidProxyId(ProxyId proxyId) {
    return proxyId != null && proxyId.isValid();
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
    for (var i=0; i<aList.length; i++){
      if (aList.elementAt(i) != bList.elementAt(i)) {
        return false;
      }
    }
    return true;
  }
}
