class ProxyUniverse {
  static const String PRODUCTION = "production";

  static const String TEST = "test";

  static bool isProduction(String universe) {
    return PRODUCTION == universe;
  }
}
