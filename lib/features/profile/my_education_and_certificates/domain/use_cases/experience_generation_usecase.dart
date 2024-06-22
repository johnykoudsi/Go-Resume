import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/domain/reposotories/education_actions_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';

class EducationGenerationUsecase {
  final EducationActionsRepo educationActionsRepo;

  EducationGenerationUsecase(this.educationActionsRepo);

  Future call(PostEducationGenerationEvent postEducationGenerationEvent) async {
    return await educationActionsRepo
        .generateEducation(postEducationGenerationEvent);
  }
}
