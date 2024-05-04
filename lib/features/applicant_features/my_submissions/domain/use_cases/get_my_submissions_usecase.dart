


import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/repositories/my_submissions_repo.dart';

import '../../presentation/bloc/my_submissions_bloc.dart';

class GetMySubmissionsUseCase {
  final MySubmissionsRepo mySubmissionsRepo;

  GetMySubmissionsUseCase(this.mySubmissionsRepo);

  Future call(GetMySubmissionsEvent event) async {
    return await mySubmissionsRepo.getMySubmissionsRequestRepo(event);
  }
}
