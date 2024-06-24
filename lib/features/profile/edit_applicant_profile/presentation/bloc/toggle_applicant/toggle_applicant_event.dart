part of 'toggle_applicant_bloc.dart';

abstract class ToggleApplicantEvent extends Equatable {
  const ToggleApplicantEvent();
}
class ToggleApplicantApiEvent extends ToggleApplicantEvent{
  int id;
  ToggleApplicantApiEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class GetApplicantStatusEvent extends ToggleApplicantEvent{
  int id;
  GetApplicantStatusEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}