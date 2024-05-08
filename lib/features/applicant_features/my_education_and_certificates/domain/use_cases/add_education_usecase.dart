
import '../../presentation/bloc/education_actions_bloc.dart';
import '../reposotories/education_actions_repo.dart';


class AddEducationUsecase {
  final EducationActionsRepo educationActionsRepo;

  AddEducationUsecase(this.educationActionsRepo);

  Future call(AddEducationEvent addEducationEvent) async {
    return await educationActionsRepo.addNewEducation(addEducationEvent);
  }
}