part of 'toggle_company_bloc.dart';

abstract class ToggleCompanyEvent extends Equatable {
  const ToggleCompanyEvent();
}
class AddView extends ToggleCompanyEvent {
  int id;
  AddView({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class ToggleCompanyApiEvent extends ToggleCompanyEvent{
  int id;
  ToggleCompanyApiEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
class GetCompanyStatusEvent extends ToggleCompanyEvent{
  int id;
  GetCompanyStatusEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}