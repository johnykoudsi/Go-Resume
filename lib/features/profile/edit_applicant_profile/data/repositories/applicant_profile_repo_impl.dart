


import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/bio_generation/bio_generation_bloc.dart';

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

  @override
  Future generateBio(PostBioGenerationEvent postBioGenerationEvent) {
    return applicantProfileDataSource.generateBio(postBioGenerationEvent);

  }
}
