part of 'edit_job_bloc.dart';

sealed class EditJobState extends Equatable {
  const EditJobState();
}

final class EditJobInitialState extends EditJobState {
  @override
  List<Object> get props => [];
}

final class EditJobLoadingState extends EditJobState {
  @override
  List<Object> get props => [];
}

final class EditJobResponseState extends EditJobState {
  EditJobResponseState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}