part of 'apply_for_job_bloc.dart';

sealed class ApplyForJobEvent extends Equatable {
  const ApplyForJobEvent();
}
class ApplyForJobApiEvent extends ApplyForJobEvent{
  int id;
  ApplyForJobApiEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class IsAppliedToJobEvent extends ApplyForJobEvent{
  int id;
  IsAppliedToJobEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}