

import 'package:smart_recruitment_flutter_user/features/job/domain/repositories/job_repo.dart';

import '../../presentation/bloc/work_fields/work_fields_bloc.dart';


class GetWorkFieldsUseCase {
  final JobRepo jobRepo;

  GetWorkFieldsUseCase(this.jobRepo);

  Future call(GetWorkFieldsEvent getWorkFieldsEvent) async {
    return await jobRepo.getWorkFields(getWorkFieldsEvent);
  }
}