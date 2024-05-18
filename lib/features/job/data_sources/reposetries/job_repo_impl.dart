import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
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

}
