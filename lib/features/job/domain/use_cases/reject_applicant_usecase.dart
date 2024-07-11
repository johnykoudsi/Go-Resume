

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';

import '../../presentation/bloc/work_fields/work_fields_bloc.dart';


class RejectApplicantUseCase {
  final JobRepo jobRepo;

  RejectApplicantUseCase(this.jobRepo);

  Future call(RejectApplicantEvent rejectApplicantEvent) async {
    return await jobRepo.rejectApplicant(rejectApplicantEvent);
  }
}