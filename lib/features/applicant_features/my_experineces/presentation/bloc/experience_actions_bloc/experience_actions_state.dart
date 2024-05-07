part of 'experience_actions_bloc.dart';

abstract class ExperienceActionsState extends Equatable {
  const ExperienceActionsState();
}

class ExperienceActionsInitial extends ExperienceActionsState {
  @override
  List<Object> get props => [];
}

class ExperienceActionsLoadingState extends ExperienceActionsState {
  @override
  List<Object> get props => [];
}

class ExperienceActionsResponseState extends ExperienceActionsState {
  ExperienceActionsResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}