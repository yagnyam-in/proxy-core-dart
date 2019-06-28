import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:proxy_core/core.dart';

class ProxyHttpClient {
  static http.Client client() {
    return http.Client();
  }
}

mixin HttpClientUtils on ProxyUtils {
  Future<String> get(
    http.Client httpClient,
    String url, {
    bool close = true,
    String basicAuthorization,
  }) async {
    assert(isNotEmpty(url));
    try {
      http.Response response = await httpClient.get(
        url,
        headers: headers(
          basicAuthorization: basicAuthorization,
        ),
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      throw HttpException("GET $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      if (close) {
        httpClient.close();
      }
    }
  }

  Future<String> post(
    http.Client httpClient,
    String url, {
    @required String body,
    bool close = true,
    String basicAuthorization,
  }) async {
    assert(isNotEmpty(url));
    try {
      http.Response response = await httpClient.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        ...headers(
          basicAuthorization: basicAuthorization,
        ),
      });
      if (response.statusCode == 200) {
        return response.body;
      }
      throw HttpException("POST $url failed with ${response.statusCode}: ${response.body}");
    } finally {
      if (close) {
        httpClient.close();
      }
    }
  }

  Map<String, String> headers({String basicAuthorization}) {
    return {
      if (isNotEmpty(basicAuthorization)) 'Authorization': 'Basic $basicAuthorization',
    };
  }
}
