import 'dart:convert';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/entities/benefits_entity.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/benefits/benefits_bloc.dart';

class JobDataSource {
  JobDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addNewJob(AddNewJobEvent addNewJobEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addNewJob,
      body: json.encode(addNewJobEvent.toMapBody()),
    );
    return helperResponse;
  }
  Future getBenefits({
    required GetBenefitsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getBenefits,
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      print("jjjjjj"+helperResponse.response);
      try {
        return welcomeBenefitsFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError,
        );
      }
    }
    return helperResponse;
  }
}
