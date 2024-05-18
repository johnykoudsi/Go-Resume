part of 'get_skills_bloc.dart';

sealed class GetSkillsState extends Equatable {
  const GetSkillsState();
}

final class GetSkillsLoadingState extends GetSkillsState {
  @override
  List<Object> get props => [];
}

final class GetSkillsLoadedState extends GetSkillsState {
  GetSkillsLoadedState({required this.skills});
  List<Skill> skills;
  @override
  List<Object> get props => [skills];
}

final class GetSkillsErrorState extends GetSkillsState {
  GetSkillsErrorState({required this.response});
  HelperResponse response;
  @override
  List<Object> get props => [response];
}
