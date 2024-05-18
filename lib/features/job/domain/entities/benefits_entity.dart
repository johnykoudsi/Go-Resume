// To parse this JSON data, do
//
//     final welcomeBenefits = welcomeBenefitsFromJson(jsonString);

import 'dart:convert';

WelcomeBenefits welcomeBenefitsFromJson(String str) => WelcomeBenefits.fromJson(json.decode(str));

String welcomeBenefitsToJson(WelcomeBenefits data) => json.encode(data.toJson());

class WelcomeBenefits {
  List<BenefitEntity> data;
  String message;
  int status;

  WelcomeBenefits({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WelcomeBenefits.fromJson(Map<String, dynamic> json) => WelcomeBenefits(
    data: List<BenefitEntity>.from(json["data"].map((x) => BenefitEntity.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class BenefitEntity {
  int id;
  String name;
  String description;

  BenefitEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory BenefitEntity.fromJson(Map<String, dynamic> json) => BenefitEntity(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}
