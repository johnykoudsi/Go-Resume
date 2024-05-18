
import '../../presentation/bloc/education_actions_bloc.dart';
import '../reposotories/education_actions_repo.dart';


class DeleteEducationUsecase {
  final EducationActionsRepo educationActionsRepo;

  DeleteEducationUsecase(this.educationActionsRepo);

  Future call(DeleteEducationEvent deleteEducationEvent) async {
    return await educationActionsRepo.deleteEducation(deleteEducationEvent);
  }
}