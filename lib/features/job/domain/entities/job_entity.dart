import 'dart:convert';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/benefits_entity.dart';

List<JobEntity> jobEntityFromJson(String str) =>
    List<JobEntity>.from(json.decode(str).map((x) => JobEntity.fromJson(x)));

class JobEntity {
  int id;
  int companyId;
  User? company;
  DateTime? startDate;
  JobTypes type;
  GenderEnum gender;
  num expectedSalary;
  int maxSalary;
  int minSalary;
  String position;
  int experienceYears;
  int workHours;
  String compensation;
  String description;
  int workFieldId;
  DateTime? createdAt;
  List<BenefitEntity> benefits;
  List<User> applicants;

  JobEntity({
    this.id = -1,
    this.companyId = -1,
    this.company,
    this.startDate,
    this.type = JobTypes.full_time,
    this.gender = GenderEnum.none,
    this.expectedSalary = 0,
    this.maxSalary = 0,
    this.minSalary = 0,
    this.position = "",
    this.experienceYears = 0,
    this.workHours = 0,
    this.compensation = "",
    this.description = "",
    this.workFieldId = -1,
    this.createdAt,
    this.benefits = const [],
    this.applicants = const [],
  });

  factory JobEntity.fromJson(Map<String, dynamic> json) => JobEntity(
        id: json["id"] ?? -1,
        companyId: json["company_id"] ?? -1,
        company:
            json["company"] != null ? User.fromJson(json["company"]) : null,
        startDate:
            DateTime.tryParse(json["start_date"] ?? '') ?? DateTime(1970),
        type: JobTypes.values
            .firstWhere((element) => element.name == json["type"], orElse: () {
          return JobTypes.full_time;
        }),
        gender: GenderEnum.values.firstWhere(
            (element) => element.name == json["gender"], orElse: () {
          return GenderEnum.none;
        }),
        expectedSalary: json["expected_salary"] ?? 0,
        maxSalary: json["max_salary"] ?? 0,
        minSalary: json["min_salary"] ?? 0,
        position: json["position"] ?? "",
        experienceYears: json["experience_years"] ?? 0,
        workHours: json["work_hours"] ?? 0,
        compensation: json["compensation"] ?? "",
        description: json["description"] ?? '',
        workFieldId: json["work_field_id"] ?? 0,
        createdAt:
            DateTime.tryParse(json["created_at"] ?? '') ?? DateTime(1970),
        benefits: json["benefits"] != null
            ? List<BenefitEntity>.from(
                json["benefits"].map((x) => BenefitEntity.fromJson(x)))
            : [],
        applicants:
            List<User>.from(json["applicants"].map((x) => User.fromJson(x))),
      );
}
