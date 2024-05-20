
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/policies_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../../domain/repositories/policies_actions_repo.dart';


class PoliciesActionsRepoImpl extends PoliciesActionsRepo {
  PoliciesActionsRepoImpl(this.policiesActionsDataSource);

  PoliciesActionsDataSource policiesActionsDataSource;

  @override
  Future addPolicy(AddPolicyEvent addPolicyEvent) async {
    return await policiesActionsDataSource.addPolicyDataSource(addPolicyEvent);
  }

  @override
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent) async{
    return await policiesActionsDataSource.deletePolicyDataSource(deletePolicyEvent);

  }


}