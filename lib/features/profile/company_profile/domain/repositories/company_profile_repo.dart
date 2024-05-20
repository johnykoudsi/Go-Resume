import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';


abstract class CompanyProfileRepo{
  Future addPolicy(AddPolicyEvent addPolicyEvent);
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent);

}