part of 'education_generation_bloc.dart';

sealed class EducationGenerationState extends Equatable {
  const EducationGenerationState();
}

final class EducationGenerationInitialState extends EducationGenerationState {
  @override
  List<Object> get props => [];
}

final class EducationGenerationLoadingState extends EducationGenerationState {
  @override
  List<Object> get props => [];
}

final class EducationGenerationErrorState extends EducationGenerationState {
  EducationGenerationErrorState({required this.response});
  HelperResponse response;
  @override
  List<Object> get props => [response];
}

final class EducationGenerationDoneState extends EducationGenerationState {
  const EducationGenerationDoneState({required this.generation});
  final String generation;
  @override
  List<Object> get props => [generation];
}
