

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';

class CancelApplicationUseCase {
  final JobRepo jobRepo;

  CancelApplicationUseCase(this.jobRepo);

  Future call(CancelApplicationEvent cancelApplicationEvent) async {
    return await jobRepo.cancelApplication(cancelApplicationEvent);
  }
}