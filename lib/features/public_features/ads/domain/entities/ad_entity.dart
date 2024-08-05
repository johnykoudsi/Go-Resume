// To parse this JSON data, do
//
//     final adEntity = adEntityFromJson(jsonString);

import 'dart:convert';

AdEntity adEntityFromJson(String str) => AdEntity.fromJson(json.decode(str));

String adEntityToJson(AdEntity data) => json.encode(data.toJson());

class AdEntity {
  List<Ad> data;
  String message;
  int status;

  AdEntity({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AdEntity.fromJson(Map<String, dynamic> json) => AdEntity(
    data: List<Ad>.from(json["data"].map((x) => Ad.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Ad {
  int id;
  String title;
  String description;
  String image;

  Ad({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
  };
}
