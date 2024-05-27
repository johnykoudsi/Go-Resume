part of 'toggle_job_bloc.dart';

sealed class ToggleJobEvent extends Equatable {
  const ToggleJobEvent();
}
class ToggleJobApiEvent extends ToggleJobEvent{
  int id;
  ToggleJobApiEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class GetJobStatusEvent extends ToggleJobEvent{
  int id;
  GetJobStatusEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}