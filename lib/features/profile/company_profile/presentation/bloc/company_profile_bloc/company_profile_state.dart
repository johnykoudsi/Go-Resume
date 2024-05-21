part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState();
}

class CompanyProfileInitial extends CompanyProfileState {
  @override
  List<Object> get props => [];
}
class CompanyProfileLoading extends CompanyProfileState {
  @override
  List<Object> get props => [];
}

class CompanyProfileResponseState extends CompanyProfileState {
  CompanyProfileResponseState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse.servicesResponse,helperResponse.response];
}