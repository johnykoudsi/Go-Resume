import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

import '../../presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';


class CompanyProfileDataSource {
  CompanyProfileDataSource(this.networkHelpers);
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

  Future getAllCompanyDataSource(GetAllCompanySearchEvent getAllCompanySearchEvent) async {
    String queryString =
        Uri(queryParameters: getAllCompanySearchEvent.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getCompanies}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return  List<User>.from(data.map((x) => User.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
