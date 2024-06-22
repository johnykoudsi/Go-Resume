
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/bio_generation/bio_generation_bloc.dart';
import '../repositories/applicant_profile_repo.dart';

class BioGenerationUsecase {
  final ApplicantProfileRepo applicantProfileRepo;

  BioGenerationUsecase(this.applicantProfileRepo);

  Future call(PostBioGenerationEvent postBioGenerationEvent) async {
    return await applicantProfileRepo.generateBio(postBioGenerationEvent);
  }
}