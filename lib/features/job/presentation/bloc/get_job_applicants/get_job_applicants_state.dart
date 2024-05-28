part of 'get_job_applicants_bloc.dart';

sealed class GetJobApplicantsState extends Equatable {
  const GetJobApplicantsState();
}

class GetJobApplicantsLoadingState extends GetJobApplicantsState {
  @override
  List<Object> get props => [];
}

class GetJobApplicantsLoadedState extends GetJobApplicantsState {
  List<User> applicantsList;
  bool hasReachedMax;

  GetJobApplicantsLoadedState(
      {this.applicantsList = const <User>[],
        required this.hasReachedMax});

  GetJobApplicantsLoadedState copyWith({
    List<User>? applicantsList,
    bool? hasReachedMax,
  }) {
    return GetJobApplicantsLoadedState(
      applicantsList: applicantsList ?? this.applicantsList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [applicantsList, hasReachedMax];
}


class GetJobApplicantsErrorState extends GetJobApplicantsState {
  GetJobApplicantsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}