part of 'experience_generation_bloc.dart';

sealed class ExperienceGenerationState extends Equatable {
  const ExperienceGenerationState();
}

final class ExperienceGenerationInitialState extends ExperienceGenerationState {
  @override
  List<Object> get props => [];
}

final class ExperienceGenerationLoadingState extends ExperienceGenerationState {
  @override
  List<Object> get props => [];
}

final class ExperienceGenerationErrorState extends ExperienceGenerationState {
  ExperienceGenerationErrorState({required this.response});
  HelperResponse response;
  @override
  List<Object> get props => [response];
}

final class ExperienceGenerationDoneState extends ExperienceGenerationState {
  const ExperienceGenerationDoneState({required this.generation});
  final String generation;
  @override
  List<Object> get props => [generation];
}
