part of 'work_fields_bloc.dart';

abstract class WorkFieldsEvent extends Equatable {
  const WorkFieldsEvent();
}
class GetWorkFieldsEvent extends WorkFieldsEvent{
  @override
  List<Object?> get props => [];
}