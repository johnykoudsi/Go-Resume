// To parse this JSON data, do
//
//     final welcomeToMyNotifications = welcomeToMyNotificationsFromJson(jsonString);

import 'dart:convert';


WelcomeToMyNotifications welcomeToMyNotificationsFromJson(String str) => WelcomeToMyNotifications.fromJson(json.decode(str));

class WelcomeToMyNotifications {
  WelcomeToMyNotifications({
    this.notificationModel = const[]
  });
  List<NotificationModel> notificationModel;
  factory WelcomeToMyNotifications.fromJson(Map<String, dynamic> json) => WelcomeToMyNotifications(
      notificationModel: List<NotificationModel>.from(json["data"]["data"].map((x) => NotificationModel.fromJson(x)))

  );
}
class NotificationModel {
  int id;

  int userId;
  int notificationId;
  UserNotification notification;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.notificationId,
    required this.notification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"]??-1,
    notificationId: json["notification_id"]??-1,
    notification: UserNotification.fromJson(json["notification"]),
  );

}

class UserNotification {
  int id;
  String head;
  String body;
  dynamic createdAt;

  UserNotification({
    required this.id,
    required this.head,
    required this.body,
    required this.createdAt,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) => UserNotification(
    id: json["id"],
    head: json["title"]??"",
    body: json["body"]??"",
    createdAt: json["created_at"],
  );

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
}