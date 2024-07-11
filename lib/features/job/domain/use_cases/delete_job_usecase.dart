

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';

class DeleteJobUseCase {
  final JobRepo jobRepo;

  DeleteJobUseCase(this.jobRepo);

  Future call(DeleteJobEvent deleteJobEvent) async {
    return await jobRepo.deleteJob(deleteJobEvent);
  }
}