part of 'education_actions_bloc.dart';

abstract class EducationActionsState extends Equatable {
  const EducationActionsState();
}

class EducationActionsInitial extends EducationActionsState {
  @override
  List<Object> get props => [];
}

class EducationActionsLoadingState extends EducationActionsState {
  @override
  List<Object> get props => [];
}

class EducationActionsResponseState extends EducationActionsState {
  EducationActionsResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}