import '../../presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';

abstract class ExperienceActionsRepo{
  Future addNewExperience(AddExperienceEvent addExperienceEvent);

}