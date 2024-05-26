part of 'my_submissions_bloc.dart';

abstract class MySubmissionsState   {
}

class MySubmissionsInitial extends MySubmissionsState {
  @override
  List<Object> get props => [];
}

class MySubmissionsLoadedState extends MySubmissionsState {
  List<JobEntity> submissions;
  bool hasReachedMax;

  MySubmissionsLoadedState(
      {this.submissions = const <JobEntity>[],
        required this.hasReachedMax});

  MySubmissionsLoadedState copyWith({
    List<JobEntity>? jobs,
    bool? hasReachedMax,
  }) {
    return MySubmissionsLoadedState(
      submissions: jobs ?? this.submissions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [submissions, hasReachedMax];
}


class MySubmissionsErrorState extends MySubmissionsState {
  MySubmissionsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}