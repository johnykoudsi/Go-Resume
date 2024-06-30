

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';

import '../../presentation/bloc/work_fields/work_fields_bloc.dart';


class IsAppliedToJobUseCase {
  final JobRepo jobRepo;

  IsAppliedToJobUseCase(this.jobRepo);

  Future call(IsAppliedToJobEvent isAppliedToJobEvent) async {
    return await jobRepo.isAppliedToJob(isAppliedToJobEvent);
  }
}