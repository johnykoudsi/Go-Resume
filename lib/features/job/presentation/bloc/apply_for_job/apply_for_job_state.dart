part of 'apply_for_job_bloc.dart';

sealed class ApplyForJobState extends Equatable {
  const ApplyForJobState();
}

final class ApplyForJobInitial extends ApplyForJobState {
  @override
  List<Object> get props => [];
}
class ApplyForJobLoadingState extends ApplyForJobState {
  @override
  List<Object> get props => [];
}

class ApplyForJobResponseState extends ApplyForJobState {
  ApplyForJobResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}