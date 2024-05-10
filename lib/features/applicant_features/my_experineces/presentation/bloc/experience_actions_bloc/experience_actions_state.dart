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

class ExperienceActionsDoneState extends ExperienceActionsState {

  @override
  List<Object> get props => [];
}
class ExperienceActionsErrorState extends ExperienceActionsState {
  ExperienceActionsErrorState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}