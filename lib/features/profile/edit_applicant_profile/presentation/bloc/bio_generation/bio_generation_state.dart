part of 'bio_generation_bloc.dart';

sealed class BioGenerationState extends Equatable {
  const BioGenerationState();
}

final class BioGenerationInitialState extends BioGenerationState {
  @override
  List<Object> get props => [];
}

final class BioGenerationLoadingState extends BioGenerationState {
  @override
  List<Object> get props => [];
}

final class BioGenerationErrorState extends BioGenerationState {
  BioGenerationErrorState({required this.response});
  HelperResponse response;
  @override
  List<Object> get props => [response];
}

final class BioGenerationDoneState extends BioGenerationState {
  const BioGenerationDoneState({required this.generation});
  final String generation;
  @override
  List<Object> get props => [generation];
}
