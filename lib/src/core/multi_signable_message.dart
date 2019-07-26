import 'multi_signed_message.dart';
import 'proxy_id.dart';
import 'proxy_object.dart';
import 'signed_message.dart';

/// Interface that need to be implemented by all the messages that need multiple signatures
abstract class MultiSignableMessage extends ProxyBaseObject {
  Set<ProxyId> getValidSigners();

  int minimumRequiredSignatures();

  bool validateSigners(Set<ProxyId> signers) {
    Set<ProxyId> validSigners = getValidSigners();
    return validSigners.containsAll(signers);
  }

  String toReadableString();

  @override
  bool isValid();

  bool hasSufficientSignatures(Set<ProxyId> signers) {
    return validateSigners(signers) && signers.length >= minimumRequiredSignatures();
  }

  String get messageType;

  bool cabBeSignedBy(ProxyId signerId) {
    return getValidSigners().any((s) => signerId.canSignOnBehalfOf(s));
  }

  /// Return Signed Messages those are children of message.
  ///
  /// This information is used to Verify if the message contains all verified Signed Messages
  List<SignedMessage> getSignedChildMessages();

  /// Return Multi Signed Messages those are children of message.
  ///
  /// This information is used to Verify if the message contains all verified Multi Signed Messages
  List<MultiSignedMessage> getMultiSignedChildMessages();

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
