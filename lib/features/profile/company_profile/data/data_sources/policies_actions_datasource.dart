import 'dart:convert';

import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

import '../../presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';


class PoliciesActionsDataSource {
  PoliciesActionsDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addPolicyDataSource(AddPolicyEvent addPolicyEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addPolicy,
      body: json.encode(addPolicyEvent.toJson()),
    );
    return helperResponse;
  }
  Future deletePolicyDataSource(DeletePolicyEvent deletePolicyEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deletePolicy(id: deletePolicyEvent.id),
    );
    return helperResponse;
  }
}
