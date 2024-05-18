
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/domain/repositories/experience_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

class AddExperienceUsecase {
  final ExperienceActionsRepo experienceActionsRepo;

  AddExperienceUsecase(this.experienceActionsRepo);

  Future call(AddExperienceEvent addExperienceEvent) async {
    return await experienceActionsRepo.addNewExperience(addExperienceEvent);
  }
}