part of 'skill_actions_bloc.dart';

abstract class SkillActionsState extends Equatable {
  const SkillActionsState();
}

class SkillActionsInitial extends SkillActionsState {
  @override
  List<Object> get props => [];
}

class SkillActionsLoadingState extends SkillActionsState {
  @override
  List<Object> get props => [];
}

class SkillActionsResponseState extends SkillActionsState {
  SkillActionsResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}