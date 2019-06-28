import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:proxy_core/core.dart';
import 'package:proxy_core/services.dart';
import "package:test/test.dart";

http.Client mockHttpClient(String url, http.Response response) {
  return new MockClient((request) async {
    if (request.url.path == url) {
      return response;
    }
    throw UnimplementedError("Only $url is handled");
  });
}

class HttpClientUtilsImpl with ProxyUtils, HttpClientUtils {
  HttpClientUtilsImpl();
}

main() {
  test('HttpClientUtils.get Success', () async {
    http.Client mockClient = mockHttpClient("/hello", http.Response("hello-there", 200));
    expect(await HttpClientUtilsImpl().get(mockClient, "/hello"), "hello-there");
  });

  test('HttpClientUtils.get Error Status', () async {
    http.Client mockClient = mockHttpClient("/hello", http.Response("hello-there", 400));
    expect(HttpClientUtilsImpl().get(mockClient, "/hello"), throwsA(const TypeMatcher<HttpException>()));
  });
  test('HttpClientUtils.post Success', () async {
    http.Client mockClient = mockHttpClient("/hello", http.Response("hello-there", 200));
    expect(await HttpClientUtilsImpl().post(mockClient, "/hello", body: "dummy-data"), "hello-there");
  });

  test('HttpClientUtils.post Error Status', () async {
    http.Client mockClient = mockHttpClient("/hello", http.Response("hello-there", 400));
    expect(HttpClientUtilsImpl().post(mockClient, "/hello", body: "dummy-data"),
        throwsA(const TypeMatcher<HttpException>()));
  });
}
