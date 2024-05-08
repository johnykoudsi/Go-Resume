part of 'education_actions_bloc.dart';

abstract class EducationActionsEvent extends Equatable {
  const EducationActionsEvent();
}
class AddEducationEvent extends EducationActionsEvent {
  AddEducationEvent(
      {required this.name,
        required this.university,
        required this.startDate,
        required this.endDate,
        required this.description,
        required this.grade,
        required this.link,
      });
  String name;
  String grade;
  String university;
  String description;
  String startDate;
  String endDate;
  String link;
  Map<String, dynamic> toJson() {
    final json = {
      "name": name,
      "description": description,
      "start_date": startDate,
      "end_date": endDate,
      "grade": grade,
      "link": link,
      "university": university,

    };
    json.removeWhere((key, value) => value==null||value ==""||value.isEmpty||value=="null");
    return json;
  }
  @override
  List<Object?> get props => [name,grade,university,description,startDate,endDate,link];
}