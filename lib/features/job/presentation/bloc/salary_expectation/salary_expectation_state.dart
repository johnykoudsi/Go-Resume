part of 'salary_expectation_bloc.dart';

sealed class SalaryExpectationState extends Equatable {
  const SalaryExpectationState();
}

final class GetSalaryInitialState extends SalaryExpectationState {
  @override
  List<Object> get props => [];
}

final class GetSalaryLoadingState extends SalaryExpectationState {
  @override
  List<Object> get props => [];
}

final class GetSalaryDoneState extends SalaryExpectationState {
  GetSalaryDoneState({required this.salaryExpectationEntity});

  SalaryExpectationEntity salaryExpectationEntity;
  @override
  List<Object> get props => [salaryExpectationEntity];
}

final class GetSalaryErrorState extends SalaryExpectationState {
  GetSalaryErrorState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}
