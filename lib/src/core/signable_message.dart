import 'proxy_id.dart';
import 'proxy_object.dart';

/// Interface that need to be implemented by all the messages that can be signed
abstract class SignableMessage extends ProxyBaseObject {

  /// Single Signed that can sign this message.
  ///
  /// Don't override this method if multiple signers are possible
  ProxyId signer() {
    throw UnimplementedError("Either override `validSigners` or override `signer` if this message can only be signed by single signer.");
  }

  Set<ProxyId> validSigners() {
    return Set.of([signer()]);
  }

  String toReadableString();

  @override
  bool isValid();

  String get messageType;

  bool cabBeSignedBy(ProxyId signerId) {
    return validSigners().any((s) => signerId.canSignOnBehalfOf(s));
  }

}
