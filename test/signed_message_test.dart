import 'package:proxy_core/proxy_id.dart';
import 'package:proxy_core/signed_message.dart';
import 'package:proxy_core/signed_message_signature.dart';
import "package:test/test.dart";
import 'dart:convert';

main() {
  String _encode(SignedMessage object) {
    return jsonEncode(object);
  }

  SignedMessage _decode(String jsonString) {
    Map userMap = jsonDecode(jsonString);
    return SignedMessage.fromJson(userMap);
  }

  test('signature with algo and value', () {
    SignedMessage message = SignedMessage(
      type: "type",
      payload: "payload",
      signedBy: ProxyId.any(),
      signatures: [SignedMessageSignature("algo", "sign")],
    );
    expect(message.isValid(), true);
    expect(_encode(message),
        """{"type":"type","payload":"payload","signedBy":{"id":"any"},"signatures":[{"algorithm":"algo","value":"sign"}]}""");
    expect(
        _decode(
            """{"type":"type","payload":"payload","signedBy":{"id":"any"},"signatures":[{"algorithm":"algo","value":"sign"}]}"""),
        message);
  });
}
