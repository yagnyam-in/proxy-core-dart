mixin DebugUtils {
  void printJson(Map jsonMap, [int depth = 0]) {
    String prefix = "".padLeft(depth);
    jsonMap.forEach((k, v) {
      if (v is Map) {
        print("$prefix $k: {");
        printJson(v, depth + 2);
        print("$prefix }");
      } else {
        print("$prefix $k: $v");
      }
    });
  }
}
