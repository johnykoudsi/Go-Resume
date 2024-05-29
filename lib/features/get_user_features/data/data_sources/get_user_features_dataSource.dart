import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_pinned_applicants/get_pinned_applicants_bloc.dart';

class GetUserFeaturesDataSource{
  GetUserFeaturesDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;
  Future getPinnedApplicants({required GetPinnedApplicantsSearchEvent event}) async {
    String queryString =
        Uri(queryParameters: event.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getPinnedApplicants}?$queryString";

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