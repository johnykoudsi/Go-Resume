
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/policies_actions_repo.dart';

class DeletePolicyUsecase {
  final PoliciesActionsRepo policiesActionsRepo;

  DeletePolicyUsecase(this.policiesActionsRepo);

  Future call(DeletePolicyEvent deletePolicyEvent) async {
    return await policiesActionsRepo.deletePolicy(deletePolicyEvent);
  }
}