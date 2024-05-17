// To parse this JSON data, do
//
//     final welcomeWorkFields = welcomeWorkFieldsFromJson(jsonString);

import 'dart:convert';

WelcomeWorkFields welcomeWorkFieldsFromJson(String str) => WelcomeWorkFields.fromJson(json.decode(str));

String welcomeWorkFieldsToJson(WelcomeWorkFields data) => json.encode(data.toJson());

class WelcomeWorkFields {
  List<WorkFieldEntity> data;
  String message;
  int status;

  WelcomeWorkFields({
    required this.data,
    required this.message,
    required this.status,
  });

  factory WelcomeWorkFields.fromJson(Map<String, dynamic> json) => WelcomeWorkFields(
    data: List<WorkFieldEntity>.from(json["data"].map((x) => WorkFieldEntity.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class WorkFieldEntity {
  int id;
  String name;
  String icon;

  WorkFieldEntity({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory WorkFieldEntity.fromJson(Map<String, dynamic> json) => WorkFieldEntity(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
  };
}
