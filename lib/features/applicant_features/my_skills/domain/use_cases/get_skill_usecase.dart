

import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/domain/repositories/skill_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';

class GetSkillUsecase {
  final SkillActionsRepo skillActionsRepo;

  GetSkillUsecase(this.skillActionsRepo);

  Future call(GetAllSkillsEvent getSkillEvent) async {
    return await skillActionsRepo.getSkill(getSkillEvent);
  }
}