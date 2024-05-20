
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/company_profile_repo.dart';

class AddPolicyUsecase {
  final CompanyProfileRepo policiesActionsRepo;

  AddPolicyUsecase(this.policiesActionsRepo);

  Future call(AddPolicyEvent addPolicyEvent) async {
    return await policiesActionsRepo.addPolicy(addPolicyEvent);
  }
}