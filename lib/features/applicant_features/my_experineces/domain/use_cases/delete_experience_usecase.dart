

import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/domain/repositories/experience_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

class DeleteExperienceUsecase {
  final ExperienceActionsRepo experienceActionsRepo;

  DeleteExperienceUsecase(this.experienceActionsRepo);

  Future call(DeleteExperienceEvent deleteExperienceEvent) async {
    return await experienceActionsRepo.deleteExperience(deleteExperienceEvent);
  }
}