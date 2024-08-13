import 'dart:convert';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/benefits_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/salary_expectation_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/work_field_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/salary_expectation/salary_expectation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

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
  Future editJob(EditMyJobEvent editMyJobEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
      crud: "PUT",
      useUserToken: true,
      url: EndPoints.editJob(id: editMyJobEvent.jobId),
      body:editMyJobEvent.toMapBody(),
    );
    return helperResponse;
  }
  Future deleteJob(DeleteJobEvent deleteJobEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deleteJob(id: deleteJobEvent.id),
    );
    return helperResponse;
  }
  Future rejectApplicant(RejectApplicantEvent rejectApplicantEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.rejectApplicant(jobId: rejectApplicantEvent.jobId, applicantId: rejectApplicantEvent.applicantId),
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
  Future cancelApplication(CancelApplicationEvent cancelApplicationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.cancelMyApplication(id: cancelApplicationEvent.id),
    );
    return helperResponse;
  }
  Future toggleJob(ToggleJobApiEvent toggleJobApiEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.saveJobToggle(id: toggleJobApiEvent.id),
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isSaved =
            json.decode(helperResponse.response)["data"]["is_saved"];
        return isSaved;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future toggleJobStatus(
      ToggleJobStatusApiEvent toggleJobStatusApiEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      crud: "PUT",
      useUserToken: true,
      url: EndPoints.closeJobToggle(id: toggleJobStatusApiEvent.id),
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isClosed =
            json.decode(helperResponse.response)["data"]["is_closed"];
        print(helperResponse.response.toString());
        return isClosed;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future isAppliedToJob({
    required IsAppliedToJobEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.isAppliedToJob(id: event.id),
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isAppliedTo =
            json.decode(helperResponse.response)["data"]["is_applied_to"];
        return helperResponse;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future getJobClosedStatus({
    required GetJobClosedStatusEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.isJobClosed(id: event.id),
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isClosed =
            json.decode(helperResponse.response)["data"]["is_closed"];
        return isClosed;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future getJobStatus({
    required GetJobStatusEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.isJobSaved(id: event.id),
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isSaved =
            json.decode(helperResponse.response)["data"]["is_saved"];
        return isSaved;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
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
        return List<JobEntity>.from(data.map((x) => JobEntity.fromJson(x)));
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
        return List<JobEntity>.from(data.map((x) => JobEntity.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future getJobApplicants(
      GetJobApplicantsSearchEvent getJobApplicantsSearchEvent) async {
    String queryString =
        Uri(queryParameters: getJobApplicantsSearchEvent.searchFilter.toJson())
            .query;

    String urlWithParams =
        "${EndPoints.getJobApplicants(id: getJobApplicantsSearchEvent.jobId)}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return List<User>.from(data.map((x) => User.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future getSalaryExpectation({required GetSalaryEvent event}) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      mainUrl: EndPoints.aiMainUrl,
      url: EndPoints.salaryPrediction,
      body: json.encode(event.toMapBody()),
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response);
        return SalaryExpectationEntity.fromJson(data);
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
