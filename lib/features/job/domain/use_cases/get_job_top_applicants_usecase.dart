

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';

class GetJobTopApplicantsUseCase {
  final JobRepo jobRepo;

  GetJobTopApplicantsUseCase(this.jobRepo);

  Future call(GetJobApplicantsTopSearchEvent getJobApplicantsTopSearchEvent) async {
    return await jobRepo.getJobTopApplicants(getJobApplicantsTopSearchEvent);
  }
}