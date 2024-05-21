
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/company_profile_repo.dart';

class DeletePolicyUsecase {
  final CompanyProfileRepo companyProfileRepo;

  DeletePolicyUsecase(this.companyProfileRepo);

  Future call(DeletePolicyEvent deletePolicyEvent) async {
    return await companyProfileRepo.deletePolicy(deletePolicyEvent);
  }
}