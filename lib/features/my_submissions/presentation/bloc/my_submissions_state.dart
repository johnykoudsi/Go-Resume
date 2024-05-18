part of 'my_submissions_bloc.dart';

abstract class MySubmissionsState   {
}

class MySubmissionsInitial extends MySubmissionsState {
  @override
  List<Object> get props => [];
}

class MySubmissionsLoadedState extends MySubmissionsState {
  List<Submission> submissions;
  bool hasReachedMax;

  MySubmissionsLoadedState(
      {this.submissions = const <Submission>[],
        required this.hasReachedMax});

  MySubmissionsLoadedState copyWith({
    List<Submission>? jobs,
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