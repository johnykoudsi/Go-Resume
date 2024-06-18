part of 'toggle_job_bloc.dart';

sealed class ToggleJobState extends Equatable {
  const ToggleJobState();
}

final class ToggleJobInitial extends ToggleJobState {
  @override
  List<Object> get props => [];
}
class ToggleJobLoadingState extends ToggleJobState {
  @override
  List<Object> get props => [];
}
class ToggleJobLoadedState extends ToggleJobState {
  bool isSaved;
  ToggleJobLoadedState(
      {
        required this.isSaved});

  // ToggleJobLoadedState copyWith({
  //   bool? isSaved,
  // }) {
  //   return ToggleJobLoadedState(
  //     isSaved: isSaved ?? this.isSaved,
  //   );
  // }

  @override
  List<Object?> get props => [isSaved];
}
class ToggleJobErrorState extends ToggleJobState {
  ToggleJobErrorState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}