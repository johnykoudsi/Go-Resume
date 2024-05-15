import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';

import '../../presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';

abstract class SkillActionsRepo{
  Future addNewSkill(AddSkillEvent addSkillEvent);
  Future getSkill(GetAllSkillsEvent getSkillEvent);

}