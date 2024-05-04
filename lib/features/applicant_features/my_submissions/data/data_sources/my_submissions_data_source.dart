import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/presentation/bloc/my_submissions_bloc.dart';


class MySubmissionsDataSource {
  MySubmissionsDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;

  Future getMySubmissionsDataSource({
    required GetMySubmissionsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getMySubmissions(page: 1, limit: 5),
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        return jobEntityFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError,
        );
      }
    }
    return helperResponse;
  }



}
