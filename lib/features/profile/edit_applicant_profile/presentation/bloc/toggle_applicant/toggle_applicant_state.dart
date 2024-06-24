part of 'toggle_applicant_bloc.dart';

abstract class ToggleApplicantState extends Equatable {
  const ToggleApplicantState();
}

class ToggleApplicantInitial extends ToggleApplicantState {
  @override
  List<Object> get props => [];
}
class ToggleApplicantLoadingState extends ToggleApplicantState {
  @override
  List<Object> get props => [];
}
class ToggleApplicantLoadedState extends ToggleApplicantState {
  bool isPinned;

  ToggleApplicantLoadedState(
      {
        required this.isPinned});

  ToggleApplicantLoadedState copyWith({
    bool? isPinned,
  }) {
    return ToggleApplicantLoadedState(
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props => [isPinned];
}
class ToggleApplicantErrorState extends ToggleApplicantState {
  ToggleApplicantErrorState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}