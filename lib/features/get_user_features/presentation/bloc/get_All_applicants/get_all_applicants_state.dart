part of 'get_all_applicants_bloc.dart';

sealed class GetAllApplicantsState extends Equatable {
  const GetAllApplicantsState();
}

class GetAllApplicantsLoadingState extends GetAllApplicantsState {
  @override
  List<Object> get props => [];
}

class GetAllApplicantsLoadedState extends GetAllApplicantsState {
  List<User> applicantsList;
  bool hasReachedMax;

  GetAllApplicantsLoadedState(
      {this.applicantsList = const <User>[],
        required this.hasReachedMax});

  GetAllApplicantsLoadedState copyWith({
    List<User>? applicantsList,
    bool? hasReachedMax,
  }) {
    return GetAllApplicantsLoadedState(
      applicantsList: applicantsList ?? this.applicantsList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [applicantsList, hasReachedMax];
}


class GetAllApplicantsErrorState extends GetAllApplicantsState {
  GetAllApplicantsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}