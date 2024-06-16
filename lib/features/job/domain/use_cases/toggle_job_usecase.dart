

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

class ToggleJobUseCase {
  final JobRepo jobRepo;

  ToggleJobUseCase(this.jobRepo);

  Future call(ToggleJobApiEvent toggleJobApiEvent) async {
    return await jobRepo.toggleJob(toggleJobApiEvent);
  }
}