
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/toggle_applicant/toggle_applicant_bloc.dart';

import '../../presentation/bloc/applicant_profile_bloc.dart';
import '../repositories/applicant_profile_repo.dart';

class GetApplicantStatusUseCase {
  final ApplicantProfileRepo applicantProfileRepo;

  GetApplicantStatusUseCase(this.applicantProfileRepo);

  Future call(GetApplicantStatusEvent getApplicantStatusEvent) async {
    return await applicantProfileRepo.getApplicantStatus(getApplicantStatusEvent);
  }
}