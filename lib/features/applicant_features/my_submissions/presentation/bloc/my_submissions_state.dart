part of 'my_submissions_bloc.dart';

abstract class MySubmissionsState   {
}

class MySubmissionsInitial extends MySubmissionsState {
  @override
  List<Object> get props => [];
}

class MySubmissionsLoadedState extends MySubmissionsState {
  List<Job> jobs;
  bool hasReachedMax;

  MySubmissionsLoadedState(
      {this.jobs = const <Job>[],
        required this.hasReachedMax});

  MySubmissionsLoadedState copyWith({
    List<Job>? jobs,
    bool? hasReachedMax,
  }) {
    return MySubmissionsLoadedState(
      jobs: jobs ?? this.jobs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [jobs, hasReachedMax];
}


class MySubmissionsErrorState extends MySubmissionsState {
  MySubmissionsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}