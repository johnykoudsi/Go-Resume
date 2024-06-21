import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';

import '../../presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

abstract class ExperienceActionsRepo{
  Future addNewExperience(AddExperienceEvent addExperienceEvent);
  Future deleteExperience(DeleteExperienceEvent deleteExperienceEvent);

  Future generateExperience(PostExperienceGenerationEvent postExperienceGeneration);

}