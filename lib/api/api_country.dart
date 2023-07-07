import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:blukers_client_app/api/model/api_country_model.dart';
import 'package:blukers_client_app/service/http_services.dart';

class CountrySearch {
  static Future<List<SearchCountry>?> countNotification() async {
    var url =
        "https://raw.githubusercontent.com/prof22/country_state_city_picker/main/lib/assets/country.json";
    http.Response? response = await HttpService.getApi(
      url: url,
    );
    if (response!.statusCode == 200) {
      return searchCountryFromJson(response.body);
    } else {
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
    }
    return null;
  }
}
