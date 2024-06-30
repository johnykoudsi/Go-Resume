part of 'salary_expectation_bloc.dart';

sealed class SalaryExpectationEvent extends Equatable {
  const SalaryExpectationEvent();
}

final class GetSalaryEvent extends SalaryExpectationEvent {
  GetSalaryEvent(
      {required this.position,
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
      required this.benefits});
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
  int workFieldId;
  List<int> benefits;
  Map<String, dynamic> toMapBody() {
    Map<String, dynamic> map = {
      "Company Size Category": benefits.length > 2 ? "Medium" : "Small",
      "Qualifications": "s",
      "Sector": "s",
      "skills": "s",
      "Industry": "s",
      "Job Title": position,
      "Role": description,
      "Preference": genderEnum.name,
      "Work Type": jobTypes.name,
      "AvgExperience": experienceYears,
      "Posting Year": DateTime.now().year,
      "Posting Month": DateTime.now().month,
    };
    // Remove entries with null or empty values
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
