part of 'get_skills_bloc.dart';

sealed class GetSkillsEvent extends Equatable {
  const GetSkillsEvent();
}

class GetAllSkillsEvent extends GetSkillsEvent{
  const GetAllSkillsEvent();
  @override
  List<Object?> get props => [];
}
