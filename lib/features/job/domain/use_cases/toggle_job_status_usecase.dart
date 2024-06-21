

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

class ToggleJobStatusUseCase {
  final JobRepo jobRepo;

  ToggleJobStatusUseCase(this.jobRepo);

  Future call(ToggleJobStatusApiEvent toggleJobStatusApiEvent) async {
    return await jobRepo.toggleJobStatus(toggleJobStatusApiEvent);
  }
}