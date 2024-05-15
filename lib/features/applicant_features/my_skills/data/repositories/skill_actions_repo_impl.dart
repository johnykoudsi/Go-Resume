import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/domain/repositories/skill_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';

import '../data_sources/skill_actions_datasource.dart';

class SkillActionsRepoImpl extends SkillActionsRepo {
  SkillActionsRepoImpl(this.skillActionsDataSource);

  SkillActionsDataSource skillActionsDataSource;

  @override
  Future addNewSkill(AddSkillEvent addSkillEvent) async {
    return await skillActionsDataSource.addSkillDataSource(addSkillEvent);
  }

  @override
  Future getSkill(GetAllSkillsEvent getSkillEvent) async {
    return await skillActionsDataSource.getSkillsDataSource(getSkillEvent);
  }
}
