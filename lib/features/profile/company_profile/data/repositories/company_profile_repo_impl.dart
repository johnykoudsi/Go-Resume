
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../../domain/repositories/company_profile_repo.dart';


class CompanyProfileRepoImpl extends CompanyProfileRepo {
  CompanyProfileRepoImpl(this.policiesActionsDataSource);

  CompanyProfileDataSource policiesActionsDataSource;

  @override
  Future addPolicy(AddPolicyEvent addPolicyEvent) async {
    return await policiesActionsDataSource.addPolicyDataSource(addPolicyEvent);
  }

  @override
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent) async{
    return await policiesActionsDataSource.deletePolicyDataSource(deletePolicyEvent);

  }


}