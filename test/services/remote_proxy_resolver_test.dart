import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import "package:test/test.dart";

http.Client mockGet(String url, http.Response response) {
  return new MockClient((request) async {
    if (request.url.path == url) {
      return response;
    }
    throw UnimplementedError("Only $url is handled");
  });
}

main() {
  test('RemoteProxyResolver.resolveProxy Success', () {
    http.Client mockClient = mockGet("/hello", http.Response("hello-there", 200));

  });
}
