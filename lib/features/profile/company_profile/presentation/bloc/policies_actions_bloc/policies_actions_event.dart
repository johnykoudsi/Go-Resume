part of 'policies_actions_bloc.dart';

abstract class PoliciesActionsEvent extends Equatable {
  const PoliciesActionsEvent();
}
class DeletePolicyEvent extends PoliciesActionsEvent{
  int id;
  DeletePolicyEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class AddPolicyEvent extends PoliciesActionsEvent {
  AddPolicyEvent(
      {
        required this.title,
        required this.description,

      });
  String title;
  String description;

  Map<String, dynamic> toJson() {
    final json = {
      "title": title,
      "description": description,

    };
    json.removeWhere((key, value) => value==null||value ==""||value.isEmpty||value=="null");
    return json;
  }
  @override
  List<Object?> get props => [title,description];
}
