


import '../../domain/repositories/applicant_profile_repo.dart';
import '../../presentation/bloc/applicant_profile_bloc.dart';
import '../data_sources/applicant_profile_datasource.dart';

class ApplicantProfileRepoImpl extends ApplicantProfileRepo {
  ApplicantProfileDataSource applicantProfileDataSource;
  ApplicantProfileRepoImpl(this.applicantProfileDataSource);
  @override
  Future edit(UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    return applicantProfileDataSource.editApplicantProfileDataSource(updateApplicantProfileEvent);
  }
}
