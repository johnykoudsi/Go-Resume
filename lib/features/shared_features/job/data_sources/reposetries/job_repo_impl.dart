import 'package:smart_recruitment_flutter_user/features/shared_features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/benefits/benefits_bloc.dart';

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

}
