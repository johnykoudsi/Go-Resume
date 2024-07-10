import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/salary_expectation/salary_expectation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';
import '../../presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';
import '../../presentation/bloc/work_fields/work_fields_bloc.dart';

abstract class JobRepo {
  Future addJob(AddNewJobEvent addNewJobEvent);
  Future getBenefits(GetBenefitsEvent getBenefitsEvent);
  Future getWorkFields(GetWorkFieldsEvent getWorkFieldsEvent);
  Future getAllJobs(GetAllJobsSearchEvent getAllJobsSearchEvent);
  Future getSavedJobs(GetSavedJobsSearchEvent getSavedJobsSearchEvent);
  Future applyForJob(ApplyForJobApiEvent applyForJobApiEvent);
  Future toggleJob(ToggleJobApiEvent toggleJobApiEvent);
  Future toggleJobStatus(ToggleJobStatusApiEvent toggleJobStatusApiEvent);
  Future getJobStatus(GetJobStatusEvent getJobStatusEvent);
  Future getJobClosedStatus(GetJobClosedStatusEvent getJobClosedStatusEvent);
  Future getJobApplicants(GetJobApplicantsSearchEvent getJobApplicantsSearchEvent);
  Future isAppliedToJob(IsAppliedToJobEvent isAppliedToJobEvent);
  Future editJob(EditMyJobEvent editMyJobEvent);

  Future getSalaryExpectation(GetSalaryEvent getSalaryEvent);

}
