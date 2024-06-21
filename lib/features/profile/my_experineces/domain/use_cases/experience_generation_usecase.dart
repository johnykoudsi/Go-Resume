import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/domain/repositories/experience_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';

class ExperienceGenerationUsecase {
  final ExperienceActionsRepo experienceActionsRepo;

  ExperienceGenerationUsecase(this.experienceActionsRepo);

  Future call(PostExperienceGenerationEvent postExperienceGeneration) async {
    return await experienceActionsRepo
        .generateExperience(postExperienceGeneration);
  }
}
