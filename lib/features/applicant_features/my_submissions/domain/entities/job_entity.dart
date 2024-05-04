// To parse this JSON data, do
//
//     final jobEntity = jobEntityFromJson(jsonString);

import 'dart:convert';

JobEntity jobEntityFromJson(String str) => JobEntity.fromJson(json.decode(str));

String jobEntityToJson(JobEntity data) => json.encode(data.toJson());

class JobEntity {
  List<Datum> data;
  String message;
  int status;

  JobEntity({
    required this.data,
    required this.message,
    required this.status,
  });

  factory JobEntity.fromJson(Map<String, dynamic> json) => JobEntity(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Datum {
  int id;
  int applicantId;
  int jobId;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.applicantId,
    required this.jobId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    applicantId: json["applicant_id"],
    jobId: json["job_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "applicant_id": applicantId,
    "job_id": jobId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
