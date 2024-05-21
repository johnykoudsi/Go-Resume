
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';

import '../../domain/repositories/company_profile_repo.dart';


class CompanyProfileRepoImpl extends CompanyProfileRepo {
  CompanyProfileRepoImpl(this.companyProfileDataSource);

  CompanyProfileDataSource companyProfileDataSource;

  @override
  Future addPolicy(AddPolicyEvent addPolicyEvent) async {
    return await companyProfileDataSource.addPolicyDataSource(addPolicyEvent);
  }

  @override
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent) async{
    return await companyProfileDataSource.deletePolicyDataSource(deletePolicyEvent);

  }

  @override
  Future getAllCompany(GetAllCompanySearchEvent getAllCompanySearchEvent) async {
    return await companyProfileDataSource.getAllCompanyDataSource(getAllCompanySearchEvent);
  }

  @override
  Future edit(UpdateCompanyProfileEvent updateCompanyProfileEvent) async{
    return await companyProfileDataSource.editCompanyProfileDataSource(updateCompanyProfileEvent);

  }


}