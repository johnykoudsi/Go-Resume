// To parse this JSON data, do
//
//     final welcomeCountriesEntity = welcomeCountriesEntityFromJson(jsonString);

import 'dart:convert';

WelcomeCountries welcomeCountriesEntityFromJson(String str) => WelcomeCountries.fromJson(json.decode(str));

String welcomeCountriesEntityToJson(WelcomeCountries data) => json.encode(data.toJson());

class WelcomeCountries {
  List<Country> data;
  String message;
  int status;

  WelcomeCountries({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WelcomeCountries.fromJson(Map<String, dynamic> json) => WelcomeCountries(
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Country {
  int id;
  String name;
  String countryCode;

  Country({
    required this.id,
    required this.name,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    countryCode: json["country_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_code": countryCode,
  };
}
