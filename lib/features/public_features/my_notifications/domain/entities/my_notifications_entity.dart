// To parse this JSON data, do
//
//     final welcomeNotifications = welcomeNotificationsFromJson(jsonString);

import 'dart:convert';

import '../../../../../utility/constant_logic_validation.dart';

WelcomeNotifications welcomeNotificationsFromJson(String str) => WelcomeNotifications.fromJson(json.decode(str));


class WelcomeNotifications {
  int currentPage;
  List<NotificationEntity> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  WelcomeNotifications({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory WelcomeNotifications.fromJson(Map<String, dynamic> json) => WelcomeNotifications(
    currentPage: json["current_page"],
    data: List<NotificationEntity>.from(json["data"].map((x) => NotificationEntity.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );


}

class NotificationEntity {
  int id;
  String title;
  String body;
  String userImage;
  int isRead;
  DateTime createdAt;
  dynamic image;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userImage,
    required this.isRead,
    required this.createdAt,
    required this.image,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => NotificationEntity(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    userImage: json["user_image"],
    isRead: json["is_read"],
    createdAt: DateTime.parse(json["created_at"]),
    image: json["image"],
  );


}

class Pivot {
  int userId;
  int notificationId;

  Pivot({
    required this.userId,
    required this.notificationId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    notificationId: json["notification_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "notification_id": notificationId,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
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
