// To parse this JSON data, do
//
//     final mySubmissionsEntity = mySubmissionsEntityFromJson(jsonString);

import 'dart:convert';

MySubmissionsEntity mySubmissionsEntityFromJson(String str) => MySubmissionsEntity.fromJson(json.decode(str));

String mySubmissionsEntityToJson(MySubmissionsEntity data) => json.encode(data.toJson());

class MySubmissionsEntity {
  List<Submission> submissions;
  String message;
  int status;

  MySubmissionsEntity({
    required this.submissions,
    required this.message,
    required this.status,
  });

  factory MySubmissionsEntity.fromJson(Map<String, dynamic> json) => MySubmissionsEntity(
    submissions: List<Submission>.from(json["data"].map((x) => Submission.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(submissions.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Submission {
  int id;
  String fullName;
  String position;
  dynamic location;
  DateTime submissionDate;

  Submission({
    required this.id,
    required this.fullName,
    required this.position,
    required this.location,
    required this.submissionDate,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json["id"],
    fullName: json["full_name"],
    position: json["position"],
    location: json["location"],
    submissionDate: DateTime.parse(json["submission_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "position": position,
    "location": location,
    "submission_date": submissionDate.toIso8601String(),
  };
}
class SubmissionsSearchFilter {
  SubmissionsSearchFilter({this.page = 1});
  int page;

  SubmissionsSearchFilter copyWith({
    int? page,
  }) =>
      SubmissionsSearchFilter(
        page: page ?? this.page,
      );
}



