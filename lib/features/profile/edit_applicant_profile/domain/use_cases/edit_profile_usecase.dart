
import '../../presentation/bloc/applicant_profile_bloc.dart';
import '../repositories/applicant_profile_repo.dart';

class EditApplicantProfileUsecase {
  final ApplicantProfileRepo applicantProfileRepo;

  EditApplicantProfileUsecase(this.applicantProfileRepo);

  Future call(UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    return await applicantProfileRepo.edit(updateApplicantProfileEvent);
  }
}