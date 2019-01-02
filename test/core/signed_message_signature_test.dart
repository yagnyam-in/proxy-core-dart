import 'package:proxy_core/core.dart';
import "package:test/test.dart";
import 'dart:convert';

main() {
  String _encode(SignedMessageSignature object) {
    return jsonEncode(object);
  }

  SignedMessageSignature _decode(String jsonString) {
    Map userMap = jsonDecode(jsonString);
    return SignedMessageSignature.fromJson(userMap);
  }

  test('signature with algo and value', () {
    SignedMessageSignature signature = SignedMessageSignature("algo", "value");
    expect(signature.isValid(), true);
    expect(_encode(signature), """{"algorithm":"algo","value":"value"}""");
    expect(_decode("""{"algorithm":"algo","value":"value"}"""), signature);
  });

}
