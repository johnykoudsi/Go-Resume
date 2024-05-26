// To parse this JSON data, do
//
//     final welcomeSubmissions = welcomeSubmissionsFromJson(jsonString);

import 'dart:convert';

WelcomeSubmissions welcomeSubmissionsFromJson(String str) => WelcomeSubmissions.fromJson(json.decode(str));

String welcomeSubmissionsToJson(WelcomeSubmissions data) => json.encode(data.toJson());

class WelcomeSubmissions {
  List<Submission> data;

  WelcomeSubmissions({
    required this.data,

  });

  factory WelcomeSubmissions.fromJson(Map<String, dynamic> json) => WelcomeSubmissions(
    data: List<Submission>.from(json["data"].map((x) => Submission.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),

  };
}

class Submission {
  Applicant applicant;
  JobVacancyEntity jobVacancy;

  Submission({
    required this.applicant,
    required this.jobVacancy,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    applicant: Applicant.fromJson(json["applicant"]),
    jobVacancy: JobVacancyEntity.fromJson(json["job_vacancy"]),
  );

  Map<String, dynamic> toJson() => {
    "applicant": applicant.toJson(),
    "job_vacancy": jobVacancy.toJson(),
  };
}

class Applicant {
  int id;
  dynamic dob;
  dynamic gender;
  dynamic resume;
  dynamic bio;
  int userId;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Applicant({
    required this.id,
    required this.dob,
    required this.gender,
    required this.resume,
    required this.bio,
    required this.userId,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
    id: json["id"],
    dob: json["dob"],
    gender: json["gender"],
    resume: json["resume"],
    bio: json["bio"],
    userId: json["user_id"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dob": dob,
    "gender": gender,
    "resume": resume,
    "bio": bio,
    "user_id": userId,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class JobVacancyEntity {
  int id;
  String description;
  int workHours;
  int experienceYears;
  String position;
  int minSalary;
  int maxSalary;
  dynamic expectedSalary;
  String gender;
  String compensation;
  String type;
  DateTime startDate;
  int companyId;
  int workFieldId;
  DateTime createdAt;
  DateTime updatedAt;

  JobVacancyEntity({
    required this.id,
    required this.description,
    required this.workHours,
    required this.experienceYears,
    required this.position,
    required this.minSalary,
    required this.maxSalary,
    required this.expectedSalary,
    required this.gender,
    required this.compensation,
    required this.type,
    required this.startDate,
    required this.companyId,
    required this.workFieldId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobVacancyEntity.fromJson(Map<String, dynamic> json) => JobVacancyEntity(
    id: json["id"],
    description: json["description"],
    workHours: json["work_hours"],
    experienceYears: json["experience_years"],
    position: json["position"],
    minSalary: json["min_salary"],
    maxSalary: json["max_salary"],
    expectedSalary: json["expected_salary"],
    gender: json["gender"],
    compensation: json["compensation"],
    type: json["type"],
    startDate: DateTime.parse(json["start_date"]),
    companyId: json["company_id"],
    workFieldId: json["work_field_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "work_hours": workHours,
    "experience_years": experienceYears,
    "position": position,
    "min_salary": minSalary,
    "max_salary": maxSalary,
    "expected_salary": expectedSalary,
    "gender": gender,
    "compensation": compensation,
    "type": type,
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "company_id": companyId,
    "work_field_id": workFieldId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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



