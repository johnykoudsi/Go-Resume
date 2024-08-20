

import 'package:easy_localization/easy_localization.dart';
import 'package:smart_recruitment_core/utility/enums.dart';

enum GenderEnum{
  m,
  f,
  none,
}
enum Compensation{
  hourly_pay,
  salary,
}
enum ReportCategory{
  stolen_identity,
  bad_language,
  fraud,
  bad_behavior
}
enum JobTypes{
  none,
  contract,
  full_time,
  part_time,
  task_based,
  out_sourcing
}
enum JobSorts{
  none,
  min_salary,
  created_at
}
enum ApplicantTypes{
  none,
  contract,
  full_time,
  part_time,
  task_based,
  out_sourcing
}
enum ApplicantSorts{
  none,
  min_salary,
  created_at
}
final EnumValues jobSortsUi = EnumValues({
  "None".tr(): JobSorts.none,
  "Salary".tr(): JobSorts.min_salary,
  "New To Old".tr(): JobSorts.created_at,
});
final EnumValues jobTypesUi = EnumValues({
  "None".tr(): JobTypes.none,
  "Contract".tr(): JobTypes.contract,
  "Full time".tr(): JobTypes.full_time,
  "Part time".tr(): JobTypes.part_time,
  "Task based".tr(): JobTypes.task_based,
  "Outsourcing".tr(): JobTypes.out_sourcing,
});
final EnumValues compensationTypesUi = EnumValues({
  "Hourly Pay".tr(): Compensation.hourly_pay,
  "Salary".tr(): Compensation.salary,
});
final EnumValues reportTypesUi = EnumValues({
  "Stolen Identity".tr(): ReportCategory.stolen_identity,
  "Bad Language".tr(): ReportCategory.bad_language,
  "Fraud".tr(): ReportCategory.fraud,
  "Bad Behavior".tr(): ReportCategory.bad_behavior,
});
