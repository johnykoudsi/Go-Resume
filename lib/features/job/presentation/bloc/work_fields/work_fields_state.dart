part of 'work_fields_bloc.dart';

abstract class WorkFieldsState extends Equatable {
  const WorkFieldsState();
}

class WorkFieldsInitial extends WorkFieldsState {
  @override
  List<Object> get props => [];
}
class WorkFieldsDoneState extends WorkFieldsState {
  WorkFieldsDoneState({required this.workFields});

  List<WorkFieldEntity> workFields;
  @override
  List<Object> get props => [workFields];
}

class WorkFieldsErrorState extends WorkFieldsState {
  WorkFieldsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}