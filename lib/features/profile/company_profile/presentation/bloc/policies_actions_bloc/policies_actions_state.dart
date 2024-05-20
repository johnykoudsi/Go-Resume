part of 'policies_actions_bloc.dart';

abstract class PoliciesActionsState extends Equatable {
  const PoliciesActionsState();
}

class PoliciesActionsInitial extends PoliciesActionsState {
  @override
  List<Object> get props => [];
}
class PoliciesActionsLoadingState extends PoliciesActionsState {
  @override
  List<Object> get props => [];
}

class PoliciesActionsResponseState extends PoliciesActionsState {
  PoliciesActionsResponseState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}