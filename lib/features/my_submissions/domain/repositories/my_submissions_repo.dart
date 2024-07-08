

import '../../presentation/bloc/my_submissions_bloc.dart';

abstract class MySubmissionsRepo {

  Future getMySubmissionsRequestRepo(GetMySubmissionsEvent event);
  Future removeMySubmission(RemoveSubmissionEvent event);


}