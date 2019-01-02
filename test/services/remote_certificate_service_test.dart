import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:proxy_core/services.dart';
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
  test('RemoteCertificateService.get Success', () async {
    StringToString siso = (s) => s;
    HttpClientFactory mockClient = () {
      return mockGet("/hello", http.Response("hello-there", 200));
    };
    var service = RemoteCertificateService(
        certificatesByIdUrl: siso,
        certificateBySerialNumberUrl: siso,
        httpClientFactory: mockClient);
    expect(await service.get("/hello"), "hello-there");
  });

  test('RemoteCertificateService.get Error Status', () {
    StringToString siso = (s) => s;
    HttpClientFactory mockClient = () {
      return mockGet("/hello", http.Response("hello-there", 400));
    };
    var service = RemoteCertificateService(
        certificatesByIdUrl: siso,
        certificateBySerialNumberUrl: siso,
        httpClientFactory: mockClient);
    expect(service.get("/hello"), throwsA(const TypeMatcher<HttpException>()));
  });
}
