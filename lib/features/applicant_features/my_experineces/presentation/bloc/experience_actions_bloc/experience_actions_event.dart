part of 'experience_actions_bloc.dart';

abstract class ExperienceActionsEvent extends Equatable {
  const ExperienceActionsEvent();
}

class AddExperienceEvent extends ExperienceActionsEvent {
  AddExperienceEvent(
      {required this.position,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.workField,
      required this.company});
  String position;
  String company;
  String description;
  String workField;
  String startDate;
  String endDate;

  @override
  List<Object?> get props => [position,company,description,workField,startDate,endDate];
}
