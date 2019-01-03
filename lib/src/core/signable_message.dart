import 'proxy_id.dart';
import 'proxy_object.dart';
import 'signed_message.dart';

/// Interface that need to be implemented by all the messages that can be signed
abstract class SignableMessage extends ProxyBaseObject {

  /// Single Signed that can sign this message.
  ///
  /// Don't override this method if multiple signers are possible
  ProxyId getSigner() {
    throw UnimplementedError("Either override `validSigners` or override `signer` if this message can only be signed by single signer.");
  }

  Set<ProxyId> getValidSigners() {
    return Set.of([getSigner()]);
  }

  String toReadableString();

  @override
  bool isValid();

  String get messageType;

  bool cabBeSignedBy(ProxyId signerId) {
    return getValidSigners().any((s) => signerId.canSignOnBehalfOf(s));
  }

  /// Return Signed Messages those are children of message.
  ///
  /// This information is used to Verify if the message contains all verified Signed Messages
  List<SignedMessage> getChildMessages();


  Map<String, dynamic> toJson();
}
