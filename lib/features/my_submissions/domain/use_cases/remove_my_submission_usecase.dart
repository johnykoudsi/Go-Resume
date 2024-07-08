



import 'package:smart_recruitment_flutter_user/features/my_submissions/domain/repositories/my_submissions_repo.dart';

import '../../presentation/bloc/my_submissions_bloc.dart';

class RemoveMySubmissionUseCase {
  final MySubmissionsRepo mySubmissionsRepo;

  RemoveMySubmissionUseCase(this.mySubmissionsRepo);

  Future call(RemoveSubmissionEvent event) async {
    return await mySubmissionsRepo.removeMySubmission(event);
  }
}
