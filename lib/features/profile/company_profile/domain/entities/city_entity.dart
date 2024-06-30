// To parse this JSON data, do
//
//     final welcomeCities = welcomeCitiesFromJson(jsonString);

import 'dart:convert';

WelcomeCities welcomeCitiesFromJson(String str) => WelcomeCities.fromJson(json.decode(str));

String welcomeCitiesToJson(WelcomeCities data) => json.encode(data.toJson());

class WelcomeCities {
  List<City> data;
  String message;
  int status;

  WelcomeCities({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WelcomeCities.fromJson(Map<String, dynamic> json) => WelcomeCities(
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class City {
  int id;
  String iso31663;
  String countryCode;
  String name;

  City({
    required this.id,
    required this.iso31663,
    required this.countryCode,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    iso31663: json["iso_3166_3"],
    countryCode: json["country_code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso_3166_3": iso31663,
    "country_code": countryCode,
    "name": name,
  };
}
