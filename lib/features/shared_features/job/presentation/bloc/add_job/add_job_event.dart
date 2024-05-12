part of 'add_job_bloc.dart';

sealed class AddJobEvent extends Equatable {
  const AddJobEvent();
}

final class AddNewJobEvent extends AddJobEvent {
  AddNewJobEvent(
      {required this.position,
      required this.description,
      required this.startDate,
      required this.compensation,
      required this.genderEnum,
      required this.maxSalary,
      required this.minSalary,
      });
  String position;
  String description;
  DateTime startDate;
  GenderEnum genderEnum;
  num minSalary;
  num maxSalary;
  Compensation compensation;
  @override
  List<Object> get props => [
        position,
        description,
        startDate,
        genderEnum,
        minSalary,
        maxSalary,
        compensation
      ];
}
