import '../../presentation/bloc/education_actions_bloc.dart';

abstract class EducationActionsRepo{
  Future addNewEducation(AddEducationEvent addEducationEvent);

}