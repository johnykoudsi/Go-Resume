

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

final EnumValues jobTypesUi = EnumValues({
  "None": JobTypes.none,
  "Contract": JobTypes.contract,
  "FullTime": JobTypes.full_time,
  "PartTime": JobTypes.part_time,
  "Task Based": JobTypes.task_based,
  "Out Sourcing": JobTypes.out_sourcing,
});
final EnumValues compensationTypesUi = EnumValues({
  "Hourly Pay": Compensation.hourly_pay,
  "Salary": Compensation.salary,
});
