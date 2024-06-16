

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';

class ApplyForJobUseCase {
  final JobRepo jobRepo;

  ApplyForJobUseCase(this.jobRepo);

  Future call(ApplyForJobApiEvent applyForJobApiEvent) async {
    return await jobRepo.applyForJob(applyForJobApiEvent);
  }
}