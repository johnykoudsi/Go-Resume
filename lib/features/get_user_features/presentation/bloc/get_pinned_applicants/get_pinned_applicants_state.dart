part of 'get_pinned_applicants_bloc.dart';

sealed class GetPinnedApplicantsState extends Equatable {
  const GetPinnedApplicantsState();
}

class GetPinnedApplicantsLoadingState extends GetPinnedApplicantsState {
  @override
  List<Object> get props => [];
}

class GetPinnedApplicantsLoadedState extends GetPinnedApplicantsState {
  List<User> applicantsList;
  bool hasReachedMax;

  GetPinnedApplicantsLoadedState(
      {this.applicantsList = const <User>[],
        required this.hasReachedMax});

  GetPinnedApplicantsLoadedState copyWith({
    List<User>? applicantsList,
    bool? hasReachedMax,
  }) {
    return GetPinnedApplicantsLoadedState(
      applicantsList: applicantsList ?? this.applicantsList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [applicantsList, hasReachedMax];
}


class GetPinnedApplicantsErrorState extends GetPinnedApplicantsState {
  GetPinnedApplicantsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}