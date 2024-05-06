
import '../../presentation/bloc/applicant_profile_bloc.dart';

abstract class ApplicantProfileRepo {
  Future edit(UpdateApplicantProfileEvent updateApplicantProfileEvent);

}
