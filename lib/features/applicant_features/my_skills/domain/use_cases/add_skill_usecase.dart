

import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/domain/repositories/skill_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';

class AddSkillUsecase {
  final SkillActionsRepo skillActionsRepo;

  AddSkillUsecase(this.skillActionsRepo);

  Future call(AddSkillEvent addSkillEvent) async {
    return await skillActionsRepo.addNewSkill(addSkillEvent);
  }
}