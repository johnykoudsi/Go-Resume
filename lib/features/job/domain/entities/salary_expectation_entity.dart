

class SalaryExpectationEntity {
  num minSalary;
  num maxSalary;

  SalaryExpectationEntity({
    required this.minSalary,
    required this.maxSalary,
  });

  factory SalaryExpectationEntity.fromJson(Map<String, dynamic> json) =>
      SalaryExpectationEntity(
        maxSalary: json["salary max"],
        minSalary: json["salary min"],
      );
}
