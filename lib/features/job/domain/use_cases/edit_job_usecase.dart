

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';

class EditJobUseCase {
  final JobRepo jobRepo;

  EditJobUseCase(this.jobRepo);

  Future call(EditMyJobEvent editMyJobEvent) async {
    return await jobRepo.editJob(editMyJobEvent);
  }
}