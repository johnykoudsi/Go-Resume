

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

class GetJobStatusUseCase {
  final JobRepo jobRepo;

  GetJobStatusUseCase(this.jobRepo);

  Future call(GetJobStatusEvent getJobStatusEvent) async {
    return await jobRepo.getJobStatus(getJobStatusEvent);
  }
}