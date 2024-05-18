



import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';

class GetAllJobsUseCase {
  final JobRepo jobRepo;

  GetAllJobsUseCase(this.jobRepo);

  Future call(GetAllJobsSearchEvent getAllJobsSearchEvent) async {
    return await jobRepo.getAllJobs(getAllJobsSearchEvent);
  }
}