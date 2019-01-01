import 'package:proxy_core/proxy_id.dart';
import 'package:proxy_core/proxy_object.dart';

/// Interface that need to be implemented by all the messages that can be signed
abstract class SignableMessage extends ProxyBaseObject {

  /// Single Signed that can sign this message.
  ///
  /// Don't override this method if multiple signers are possible
  ProxyId signer();

  Set<ProxyId> validSigners() {
    return Set.of([signer()]);
  }

  String toReadableString();

  @override
  bool isValid();

  String getMessageType();

  bool cabBeSignedBy(ProxyId signerId) {
    return validSigners().any((s) => signerId.canSignOnBehalfOf(s));
  }
}
