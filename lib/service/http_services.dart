import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:blukers_client_app/service/pref_services.dart';
import 'package:blukers_client_app/utils/pref_keys.dart';

class HttpService {
  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      String accessToken = PrefService.getString(PrefKeys.registerToken);
      if (header == null && accessToken.isNotEmpty) {
        header = {
          "Content-Type": "application/json",
          "x-access-token": accessToken,
        };
      }
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
      }
      return http.get(
        Uri.parse(url),
        headers: header,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response?> postApi({
    required String url,
    dynamic body,
    Map<String, String>? header,
  }) async {
    try {
      String accessToken = PrefService.getString(PrefKeys.registerToken);
      if (header == null && accessToken.isNotEmpty) {
        header = {
          "Content-Type": "application/json",
          "x-access-token": accessToken,
        };
      }
      if (kDebugMode) {
        print("Url => $url");
        print("Header => $header");
        print("Body => $body");
      }
      return http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
      return null;
    }
  }
}
