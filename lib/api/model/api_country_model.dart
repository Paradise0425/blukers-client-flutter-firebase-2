// To parse this JSON data, do
//
//     final searchCountry = searchCountryFromJson(jsonString);

import 'dart:convert';

List<SearchCountry> searchCountryFromJson(String str) =>
    List<SearchCountry>.from(
        json.decode(str).map((x) => SearchCountry.fromJson(x)));

String searchCountryToJson(List<SearchCountry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCountry {
  SearchCountry({
    this.id,
    this.name,
    this.emoji,
    this.emojiU,
    this.state,
  });

  int? id;
  String? name;
  String? emoji;
  String? emojiU;
  List<State>? state;

  factory SearchCountry.fromJson(Map<String, dynamic> json) => SearchCountry(
        id: json["id"],
        name: json["name"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        state: List<State>.from(json["state"].map((x) => State.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emoji": emoji,
        "emojiU": emojiU,
        "state": List<dynamic>.from(state!.map((x) => x.toJson())),
      };
}

class State {
  State({
    this.id,
    this.name,
    this.countryId,
    this.city,
  });

  int? id;
  String? name;
  int? countryId;
  List<City>? city;

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "city": List<dynamic>.from(city!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.name,
    this.stateId,
  });

  int? id;
  String? name;
  int? stateId;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
      };
}
