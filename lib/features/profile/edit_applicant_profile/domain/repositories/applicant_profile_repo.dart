
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/bio_generation/bio_generation_bloc.dart';

import '../../presentation/bloc/applicant_profile_bloc.dart';

abstract class ApplicantProfileRepo {
  Future edit(UpdateApplicantProfileEvent updateApplicantProfileEvent);

  Future generateBio(PostBioGenerationEvent postBioGenerationEvent);

}
