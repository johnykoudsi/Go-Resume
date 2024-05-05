import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/entities/my_submissions_entity.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/presentation/bloc/my_submissions_bloc.dart';

import '../../../../../utility/constant_logic_validation.dart';


class MySubmissionsDataSource {
  MySubmissionsDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;

  Future getMySubmissionsDataSource({
    required GetMySubmissionsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getMySubmissions(
        page: event.searchFilterProperties.page,
        limit: kProductsGetLimit,
      ),
      useUserToken: true,
    );
    print(helperResponse.servicesResponse);

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        MySubmissionsEntity data = mySubmissionsEntityFromJson(helperResponse.response);
        return data.submissions;
      } catch (e) {
        return helperResponse.copyWith(servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

}
