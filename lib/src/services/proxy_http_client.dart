import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:proxy_core/core.dart';

class ProxyHttpClient {
  static http.Client client() {
    return http.Client();
  }
}

mixin HttpClientUtils on ProxyUtils {
  Future<String> get(http.Client httpClient, String url, {bool close = true}) async {
    assert(isNotEmpty(url));
    try {
      http.Response response = await httpClient.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      throw HttpException(
          "GET $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      if (close) {
        httpClient.close();
      }
    }
  }

  Future<String> post(http.Client httpClient, String url, String body, {bool close = true}) async {
    assert(isNotEmpty(url));
    try {
      http.Response response = await httpClient.post(url, body: body, headers: {
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        return response.body;
      }
      throw HttpException(
          "POST $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      if (close) {
        httpClient.close();
      }
    }
  }

}
