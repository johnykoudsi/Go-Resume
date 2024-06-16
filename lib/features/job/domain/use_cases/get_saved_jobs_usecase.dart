



import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';

class GetSavedJobsUseCase {
  final JobRepo jobRepo;

  GetSavedJobsUseCase(this.jobRepo);

  Future call(GetSavedJobsSearchEvent
  getSavedJobsSearchEvent) async {
    return await jobRepo.getSavedJobs(getSavedJobsSearchEvent);
  }
}