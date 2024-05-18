import 'package:smart_recruitment_flutter_user/features/profile/my_skills/data/data_sources/skill_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/domain/repositories/skill_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';


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
