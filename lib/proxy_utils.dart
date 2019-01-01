import 'package:proxy_core/proxy_object.dart';

mixin ProxyUtils {
  bool isNotEmpty(String value) {
    return value != null && value.trim().isNotEmpty;
  }

  bool isValidProxyObjectList<T extends ProxyBaseObject>(List<T> values) {
    return values != null && values.isNotEmpty && values.every((e) => e.isValid());
  }

  bool isValidDateTime(DateTime dateTime) {
    return dateTime != null;
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
