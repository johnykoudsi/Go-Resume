
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../repositories/company_profile_repo.dart';

class AddPolicyUsecase {
  final CompanyProfileRepo companyProfileRepo;

  AddPolicyUsecase(this.companyProfileRepo);

  Future call(AddPolicyEvent addPolicyEvent) async {
    return await companyProfileRepo.addPolicy(addPolicyEvent);
  }
}