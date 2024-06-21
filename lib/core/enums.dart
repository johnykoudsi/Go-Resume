

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
final EnumValues jobSortsUi = EnumValues({
  "None": JobSorts.none,
  "Salary": JobSorts.min_salary,
  "New To Old": JobSorts.created_at,
});
final EnumValues jobTypesUi = EnumValues({
  "None": JobTypes.none,
  "Contract": JobTypes.contract,
  "Full time": JobTypes.full_time,
  "Part time": JobTypes.part_time,
  "Task based": JobTypes.task_based,
  "Outsourcing": JobTypes.out_sourcing,
});
final EnumValues compensationTypesUi = EnumValues({
  "Hourly Pay": Compensation.hourly_pay,
  "Salary": Compensation.salary,
});
