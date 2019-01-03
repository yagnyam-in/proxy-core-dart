import 'package:proxy_core/core.dart';
import "package:test/test.dart";
import 'dart:convert';

main() {
  String _encode(SignedMessage message) {
    return jsonEncode(message);
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
