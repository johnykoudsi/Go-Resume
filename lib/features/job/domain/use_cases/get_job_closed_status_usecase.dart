

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

class GetJobClosedStatusUseCase {
  final JobRepo jobRepo;

  GetJobClosedStatusUseCase(this.jobRepo);

  Future call(GetJobClosedStatusEvent getJobClosedStatusEvent) async {
    return await jobRepo.getJobClosedStatus(getJobClosedStatusEvent);
  }
}