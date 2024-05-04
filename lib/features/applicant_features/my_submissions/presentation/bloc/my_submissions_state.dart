part of 'my_submissions_bloc.dart';

abstract class MySubmissionsState extends Equatable {
  const MySubmissionsState();
}

class MySubmissionsInitial extends MySubmissionsState {
  @override
  List<Object> get props => [];
}

class MySubmissionsDoneState extends MySubmissionsState {
  MySubmissionsDoneState({required this.jobs});

  List<JobEntity> jobs;
  @override
  List<Object> get props => [jobs];
}

class MySubmissionsErrorState extends MySubmissionsState {
  MySubmissionsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}