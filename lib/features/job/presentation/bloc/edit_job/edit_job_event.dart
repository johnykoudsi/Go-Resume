part of 'edit_job_bloc.dart';

sealed class EditJobEvent extends Equatable {
  const EditJobEvent();
}
final class EditMyJobEvent extends EditJobEvent {
  EditMyJobEvent({
    required this.jobId,
    required this.position,
    required this.description,
    required this.startDate,
    required this.compensation,
    required this.genderEnum,
    required this.maxSalary,
    required this.minSalary,
    required this.workHours,
    required this.jobTypes,
    required this.experienceYears,
    required this.workFieldId,
    required this.benefits,
    this.minExpectedSalary ,
    this.maxExpectedSalary,
  });
  int jobId;
  String position;
  String description;
  String startDate;
  GenderEnum genderEnum;
  num minSalary;
  num maxSalary;
  Compensation compensation;
  JobTypes jobTypes;
  num workHours;
  num experienceYears;
  String workFieldId;
  List<int> benefits;
  num? minExpectedSalary;
  num? maxExpectedSalary;
  Map<String, String> toMapBody() {
    Map<String, String> map = {
      "position": position,
      "description": description,
      "start_date": startDate,
      "gender": genderEnum.name,
      "min_salary": minSalary.toString(),
      "max_salary": maxSalary.toString(),
      "compensation": compensation.name,
      "type": jobTypes.name,
      "work_hours": workHours.toString(),
      "experience_years": experienceYears.toString(),
      "work_field_id": workFieldId.toString(),
      "expected_min_salary": minExpectedSalary.toString(),
      "expected_max_salary": maxExpectedSalary.toString(),
    }..removeWhere((key, value) => value == null || value == "null");

    if (benefits.isNotEmpty) {
      for (int i = 0; i < benefits.length; i++) {
        map["benefits[$i]"] =benefits[i].toString();
      }
    }

    // Remove entries with null or empty values
    map.removeWhere((key, value) => value.isEmpty || value == "none");
    return map;
  }

  @override
  List<Object> get props => [
    position,
    description,
    startDate,
    genderEnum,
    minSalary,
    maxSalary,
    compensation,
    jobTypes,
    workHours,
    experienceYears,
    workFieldId,
    benefits
  ];

}
