import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/salary_expectation/salary_expectation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/work_fields/work_fields_bloc.dart';

class JobRepoImpl extends JobRepo {
  JobDataSource jobDataSource;
  JobRepoImpl(this.jobDataSource);

  @override
  Future addJob(AddNewJobEvent addNewJobEvent) async {
    return jobDataSource.addNewJob(addNewJobEvent);
  }

  @override
  Future getBenefits(GetBenefitsEvent getBenefitsEvent) {
    return jobDataSource.getBenefits(event: getBenefitsEvent);
  }

  @override
  Future getWorkFields(GetWorkFieldsEvent getWorkFieldsEvent) {
    return jobDataSource.getWorkFields(event: getWorkFieldsEvent);
  }

  @override
  Future getAllJobs(GetAllJobsSearchEvent getAllJobsSearchEvent) {
    return jobDataSource.getAllJobs(event: getAllJobsSearchEvent);
  }

  @override
  Future applyForJob(ApplyForJobApiEvent applyForJobApiEvent) {
    return jobDataSource.applyForJob(applyForJobApiEvent);
  }

  @override
  Future getSavedJobs(GetSavedJobsSearchEvent getSavedJobsSearchEvent) {
    return jobDataSource.getSavedJobs(event: getSavedJobsSearchEvent);
  }

  @override
  Future toggleJob(ToggleJobApiEvent toggleJobApiEvent) {
    return jobDataSource.toggleJob(toggleJobApiEvent);
  }

  @override
  Future getJobStatus(GetJobStatusEvent getJobStatusEvent) {
    return jobDataSource.getJobStatus(event: getJobStatusEvent);
  }

  @override
  Future getJobApplicants(GetJobApplicantsSearchEvent getJobApplicantsSearchEvent) {
    return jobDataSource.getJobApplicants(getJobApplicantsSearchEvent);

  }

  @override
  Future toggleJobStatus(ToggleJobStatusApiEvent toggleJobStatusApiEvent) {
    return jobDataSource.toggleJobStatus(toggleJobStatusApiEvent);
  }

  @override
  Future getJobClosedStatus(GetJobClosedStatusEvent getJobClosedStatusEvent) {
    return jobDataSource.getJobClosedStatus(event: getJobClosedStatusEvent);

  }

  @override
  Future isAppliedToJob(IsAppliedToJobEvent isAppliedToJobEvent) {
    return jobDataSource.isAppliedToJob(event: isAppliedToJobEvent);
  }

  @override
  Future getSalaryExpectation(GetSalaryEvent getSalaryEvent) {
    return jobDataSource.getSalaryExpectation(event: getSalaryEvent);
  }
}
