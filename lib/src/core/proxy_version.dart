abstract class ProxyVersion {
  String get version;

  List<String> get signatureAlgorithms;

  String get preferredSignatureAlgorithm;

  List<String> get encryptionAlgorithms;

  String get preferredEncryptionAlgorithm;

  const ProxyVersion();

  factory ProxyVersion.latestVersion() {
    return ProxyVersionV0.instance();
  }

  factory ProxyVersion.of(String version) {
    if (ProxyVersionV0.VERSION == version) {
      return ProxyVersionV0.instance();
    }
    throw ArgumentError("Unknown version $version");
  }
}

class ProxyVersionV0 extends ProxyVersion {
  static const _instance = const ProxyVersionV0();

  static const VERSION = "v0";

  const ProxyVersionV0();

  factory ProxyVersionV0.instance() => _instance;

  @override
  String get version => VERSION;

  @override
  List<String> get encryptionAlgorithms => ["RSA/NONE/OAEPwithSHA-256andMGF1Padding"];

  @override
  String get preferredEncryptionAlgorithm => "RSA/NONE/OAEPwithSHA-256andMGF1Padding";

  @override
  String get preferredSignatureAlgorithm => "SHA256WithRSAEncryption";

  @override
  List<String> get signatureAlgorithms => ["SHA256WithRSAEncryption"];
}
