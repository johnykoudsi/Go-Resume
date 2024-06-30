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
  Map<String, String> toMapBody() {
    Map<String, String> map = {
      "Company Size Category": benefits.length > 2 ? "Medium" : "Small",
      "Qualifications": "",
      "Sector": "",
      "skills": "",
      "Job Title": position,
      "Role": description,
      "Preference": genderEnum.name,
      "Work Type": jobTypes.name,
      "AvgExperience": experienceYears.toString(),
      "Industry": workFieldId.toString(),
      "Posting Year": DateTime.now().year.toString(),
      "Posting Month": DateTime.now().month.toString(),
    };

    if (benefits.isNotEmpty) {
      for (int i = 0; i < benefits.length; i++) {
        map["benefits[$i]"] = benefits[i].toString();
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
