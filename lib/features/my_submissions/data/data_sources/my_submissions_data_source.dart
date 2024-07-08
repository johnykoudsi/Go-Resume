import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/my_submissions/presentation/bloc/my_submissions_bloc.dart';

import '../../../../../utility/constant_logic_validation.dart';
import '../../../job/domain/entities/job_entity.dart';


class MySubmissionsDataSource {
  MySubmissionsDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;

  Future getMySubmissionsDataSource({
    required GetMySubmissionsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getMySubmissions(
        page: event.searchFilterProperties.page,
        limit: kGetLimit,
      ),
      useUserToken: true,
    );
    print(helperResponse.servicesResponse);
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return  List<JobEntity>.from(data.map((x) => JobEntity.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future removeSubmissionsDataSource(
      RemoveSubmissionEvent removeSubmissionEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.removeSubmission(id: removeSubmissionEvent.id),
    );
    return helperResponse;
  }

}
