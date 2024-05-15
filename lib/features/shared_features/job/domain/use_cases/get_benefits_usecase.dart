

import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/benefits/benefits_bloc.dart';

class GetBenefitsUseCase {
  final JobRepo jobRepo;

  GetBenefitsUseCase(this.jobRepo);

  Future call(GetBenefitsEvent getBenefitsEvent) async {
    return await jobRepo.getBenefits(getBenefitsEvent);
  }
}