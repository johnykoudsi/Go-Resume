

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/salary_expectation/salary_expectation_bloc.dart';

class GetSalaryExpectationUseCase {
  final JobRepo jobRepo;

  GetSalaryExpectationUseCase(this.jobRepo);

  Future call(GetSalaryEvent getSalaryEvent) async {
    return await jobRepo.getSalaryExpectation(getSalaryEvent);
  }
}