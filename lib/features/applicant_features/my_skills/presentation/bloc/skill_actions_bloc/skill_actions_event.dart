part of 'skill_actions_bloc.dart';

abstract class SkillActionsEvent extends Equatable {
  const SkillActionsEvent();
}

class AddSkillEvent extends SkillActionsEvent {
  AddSkillEvent({required this.skills});
  List<Skill> skills;
  Map<String, String> toJson() {
    Map<String, String> map = {};
    if (skills.isNotEmpty) {
      for (int i = 0; i < skills.length; i++) {
        map["skills[$i]"] = skills[i].id.toString();
      }
    }
    return map;
  }

  @override
  List<Object?> get props => [skills];
}
