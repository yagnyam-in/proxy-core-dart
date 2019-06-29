abstract class ProxyVersion {
  String get version;

  List<Set<String>> get validSignatureAlgorithmSets;

  Set<String> get preferredSignatureAlgorithmSet;

  List<String> get validEncryptionAlgorithms;

  String get preferredEncryptionAlgorithm;

  String get certificateSignatureAlgorithm;

  String get keyGenerationAlgorithm;

  int get keySize;

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
  List<String> get validEncryptionAlgorithms => ["RSA/NONE/OAEPwithSHA-256andMGF1Padding"];

  @override
  String get preferredEncryptionAlgorithm => "RSA/NONE/OAEPwithSHA-256andMGF1Padding";

  @override
  Set<String> get preferredSignatureAlgorithmSet => {"SHA256WithRSAEncryption"};

  @override
  List<Set<String>> get validSignatureAlgorithmSets => [{"SHA256WithRSAEncryption"}];

  @override
  String get certificateSignatureAlgorithm => "SHA256WithRSAEncryption";

  @override
  String get keyGenerationAlgorithm => "RSA";

  @override
  int get keySize => 2048;

}
