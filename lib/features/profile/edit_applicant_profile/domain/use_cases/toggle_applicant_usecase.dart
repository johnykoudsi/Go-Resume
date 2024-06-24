
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/toggle_applicant/toggle_applicant_bloc.dart';

import '../../presentation/bloc/applicant_profile_bloc.dart';
import '../repositories/applicant_profile_repo.dart';

class ToggleApplicantUseCase {
  final ApplicantProfileRepo applicantProfileRepo;

  ToggleApplicantUseCase(this.applicantProfileRepo);

  Future call(ToggleApplicantApiEvent toggleApplicantApiEvent) async {
    return await applicantProfileRepo.toggleApplicant(toggleApplicantApiEvent);
  }
}