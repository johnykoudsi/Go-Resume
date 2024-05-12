

import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';

class AddJobUseCase {
  final JobRepo jobRepo;

  AddJobUseCase(this.jobRepo);

  Future call(AddNewJobEvent addNewJobEvent) async {
    return await jobRepo.addJob(addNewJobEvent);
  }
}