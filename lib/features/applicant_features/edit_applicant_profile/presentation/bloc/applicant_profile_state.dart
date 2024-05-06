part of 'applicant_profile_bloc.dart';

abstract class ApplicantProfileState extends Equatable {
  const ApplicantProfileState();
}

class ApplicantProfileInit extends ApplicantProfileState {
  @override
  List<Object> get props => [];
}
class ApplicantProfileLoading extends ApplicantProfileState {
  @override
  List<Object> get props => [];
}

class ApplicantProfileDoneState extends ApplicantProfileState {
  ApplicantProfileDoneState({required this.user});
  User user;
  @override
  List<Object> get props => [user];
}

class ApplicantProfileErrorState extends ApplicantProfileState {
  ApplicantProfileErrorState({required this.helperResponse});
  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse.servicesResponse,helperResponse.response];
}