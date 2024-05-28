

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';

class GetJobApplicantsUseCase {
  final JobRepo jobRepo;

  GetJobApplicantsUseCase(this.jobRepo);

  Future call(GetJobApplicantsSearchEvent getJobApplicantsSearchEvent) async {
    return await jobRepo.getJobApplicants(getJobApplicantsSearchEvent);
  }
}