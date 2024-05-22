import 'dart:convert';

WelcomeCountries welcomeCountriesFromJson(String str) => WelcomeCountries.fromJson(json.decode(str));

String welcomeCountriesToJson(WelcomeCountries data) => json.encode(data.toJson());

class WelcomeCountries {
  Data data;

  WelcomeCountries({
    required this.data,
  });

  factory WelcomeCountries.fromJson(Map<String, dynamic> json) => WelcomeCountries(
    data: Data.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<Country> data;
  Data({
    required this.data,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
