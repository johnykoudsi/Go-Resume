import 'dart:convert';

WelcomeCities welcomeCitiesFromJson(String str) => WelcomeCities.fromJson(json.decode(str));

String welcomeCitiesToJson(WelcomeCities data) => json.encode(data.toJson());

class WelcomeCities {
  Data data;

  WelcomeCities({
    required this.data,
  });

  factory WelcomeCities.fromJson(Map<String, dynamic> json) => WelcomeCities(
    data: Data.fromJson(json["data"]),

  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<City> data;
  Data({
    required this.data,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<City>.from(json["data"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class City {
  int id;
  String name;
  String countryCode;

  City({
    required this.id,
    required this.name,
    required this.countryCode,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
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
