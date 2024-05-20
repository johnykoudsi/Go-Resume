
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/company_profile_repo.dart';

class DeletePolicyUsecase {
  final CompanyProfileRepo policiesActionsRepo;

  DeletePolicyUsecase(this.policiesActionsRepo);

  Future call(DeletePolicyEvent deletePolicyEvent) async {
    return await policiesActionsRepo.deletePolicy(deletePolicyEvent);
  }
}