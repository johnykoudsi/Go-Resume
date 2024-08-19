part of 'report_user_bloc.dart';

sealed class ReportUserState extends Equatable {
  const ReportUserState();
}

final class ReportUserInitial extends ReportUserState {
  @override
  List<Object> get props => [];
}
final class ReportUserLoadingState extends ReportUserState {
  @override
  List<Object> get props => [];
}
class ReportUserDoneState extends ReportUserState {
  ReportUserDoneState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse.servicesResponse, helperResponse.response];
}

class ReportUserErrorState extends ReportUserState {
  ReportUserErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}