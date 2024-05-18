part of 'add_job_bloc.dart';

sealed class AddJobState extends Equatable {
  const AddJobState();
}

final class AddJobInitialState extends AddJobState {
  @override
  List<Object> get props => [];
}

final class AddJobLoadingState extends AddJobState {
  @override
  List<Object> get props => [];
}

final class AddJobResponseState extends AddJobState {
  AddJobResponseState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}
