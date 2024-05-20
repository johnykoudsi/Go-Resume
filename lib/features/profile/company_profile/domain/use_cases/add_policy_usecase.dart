
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/policies_actions_repo.dart';

class AddPolicyUsecase {
  final PoliciesActionsRepo policiesActionsRepo;

  AddPolicyUsecase(this.policiesActionsRepo);

  Future call(AddPolicyEvent addPolicyEvent) async {
    return await policiesActionsRepo.addPolicy(addPolicyEvent);
  }
}