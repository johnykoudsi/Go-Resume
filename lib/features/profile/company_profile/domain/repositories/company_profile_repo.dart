import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';


abstract class CompanyProfileRepo{
  Future addPolicy(AddPolicyEvent addPolicyEvent);
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent);
  Future getAllCompany(GetAllCompanySearchEvent getAllCompanySearchEvent);
  Future edit(UpdateCompanyProfileEvent updateCompanyProfileEvent);

}