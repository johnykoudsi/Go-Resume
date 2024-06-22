import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';

import '../../presentation/bloc/education_actions_bloc.dart';

abstract class EducationActionsRepo{
  Future addNewEducation(AddEducationEvent addEducationEvent);
  Future deleteEducation(DeleteEducationEvent deleteEducationEvent);

  Future generateEducation(PostEducationGenerationEvent postEducationGenerationEvent);

}