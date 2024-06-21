
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/domain/repositories/experience_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';

import '../data_sources/experience_actions_datasource.dart';

class ExperienceActionsRepoImpl extends ExperienceActionsRepo {
  ExperienceActionsRepoImpl(this.experienceActionsDataSource);

  ExperienceActionsDataSource experienceActionsDataSource;

  @override
  Future addNewExperience(AddExperienceEvent addExperienceEvent) async {
    return await experienceActionsDataSource.addExperienceDataSource(addExperienceEvent);
  }

  @override
  Future deleteExperience(DeleteExperienceEvent deleteExperienceEvent) async{
    return await experienceActionsDataSource.deleteExperienceDataSource(deleteExperienceEvent);

  }

  @override
  Future generateExperience(PostExperienceGenerationEvent postExperienceGeneration) async {
    return await experienceActionsDataSource.generateExperienceDataSource(postExperienceGeneration);
  }


}