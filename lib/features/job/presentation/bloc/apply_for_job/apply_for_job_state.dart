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
class IsAppliedToJobResponseState extends ApplyForJobState {
  bool isAppliedTo;
  IsAppliedToJobResponseState(
      {
        required this.isAppliedTo});
  @override
  List<Object?> get props => [isAppliedTo];
}
class ApplyForJobResponseState extends ApplyForJobState {
  ApplyForJobResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}