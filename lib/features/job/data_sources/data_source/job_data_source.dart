import 'dart:convert';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/benefits_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/work_field_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';

import '../../presentation/bloc/work_fields/work_fields_bloc.dart';

class JobDataSource {
  JobDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addNewJob(AddNewJobEvent addNewJobEvent) async {

    HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
      useUserToken: true,
      url: EndPoints.addNewJob,
      body: addNewJobEvent.toMapBody(),
    );
    return helperResponse;
  }
  Future applyForJob(ApplyForJobApiEvent applyForJobApiEvent) async {

    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.applyForJob(id: applyForJobApiEvent.id),
    );
    return helperResponse;
  }
  Future toggleJob(ToggleJobApiEvent toggleJobApiEvent) async {

    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.saveJobToggle(id: toggleJobApiEvent.id),
    );
    return helperResponse;
  }
  Future getJobStatus({
    required GetJobStatusEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getJobStatus(id: event.id),
      useUserToken: true,
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

  Future getWorkFields({
    required GetWorkFieldsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getWorkFields,
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        return welcomeWorkFieldsFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError,
        );
      }
    }
    return helperResponse;
  }

  Future getAllJobs({required GetAllJobsSearchEvent event}) async {
    String queryString =
        Uri(queryParameters: event.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getJobVacancies}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

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
  Future getSavedJobs({required GetSavedJobsSearchEvent event}) async {
    String queryString =
        Uri(queryParameters: event.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getSavedJobs}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

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
}
