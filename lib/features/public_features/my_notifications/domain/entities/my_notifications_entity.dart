// To parse this JSON data, do
//
//     final welcomeNotifications = welcomeNotificationsFromJson(jsonString);

import 'dart:convert';

import '../../../../../utility/constant_logic_validation.dart';

// To parse this JSON data, do
//
//     final notificationsEntity = notificationsEntityFromJson(jsonString);

import 'dart:convert';

NotificationsEntity notificationsEntityFromJson(String str) => NotificationsEntity.fromJson(json.decode(str));

String notificationsEntityToJson(NotificationsEntity data) => json.encode(data.toJson());

class NotificationsEntity {
  List<NotificationsModel> data;
  String message;
  int status;

  NotificationsEntity({
    required this.data,
    required this.message,
    required this.status,
  });

  factory NotificationsEntity.fromJson(Map<String, dynamic> json) => NotificationsEntity(
    data: List<NotificationsModel>.from(json["data"].map((x) => NotificationsModel.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class NotificationsModel {
  int id;
  String title;
  String body;
  dynamic userImage;
  int isRead;
  DateTime createdAt;
  dynamic image;

  NotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userImage,
    required this.isRead,
    required this.createdAt,
    required this.image,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    id: json["id"],
    title:  json["title"],
    body: json["body"],
    userImage: json["user_image"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse[title],
    "body": body,
    "user_image": userImage,
    "is_read": isRead,
    "created_at": createdAt.toIso8601String(),
    "image": image,
  };
}

enum Title {
  JOB_CLOSED,
  JOB_OPENED_AGAIN
}

final titleValues = EnumValues({
  "Job Closed": Title.JOB_CLOSED,
  "Job Opened Again!": Title.JOB_OPENED_AGAIN
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class NotificationsSearchFilter {
  NotificationsSearchFilter({this.page = 1});
  int page;

  NotificationsSearchFilter copyWith({
    int? page,
  }) =>
      NotificationsSearchFilter(
        page: page ?? this.page,
      );

  Map<String, String> toJson() {
    Map<String, String> map = {
      "page": page.toString(),
      "items_per_page": kGetLimit.toString(),
    }..removeWhere(
            (key, value) =>  value == "null" || value == "");
    return map;
  }
}
