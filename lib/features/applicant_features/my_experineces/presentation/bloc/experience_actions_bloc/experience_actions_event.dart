part of 'experience_actions_bloc.dart';

abstract class ExperienceActionsEvent extends Equatable {
  const ExperienceActionsEvent();
}
class DeleteExperienceEvent extends ExperienceActionsEvent{
  int id;
  DeleteExperienceEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
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
  Map<String, dynamic> toJson() {
    final json = {
      "title": position,
      "description": description,
      "start_date": startDate,
      "end_date": endDate,
      "work_field_id": workField,
      "company": company,

    };
    json.removeWhere((key, value) => value==null||value ==""||value.isEmpty||value=="null");
    return json;
  }
  @override
  List<Object?> get props => [position,company,description,workField,startDate,endDate];
}
