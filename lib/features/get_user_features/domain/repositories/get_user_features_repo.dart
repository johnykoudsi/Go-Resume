import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_pinned_applicants/get_pinned_applicants_bloc.dart';


abstract class GetUserFeaturesRepo {
  Future getPinnedApplicants(GetPinnedApplicantsSearchEvent getPinnedApplicantsSearchEvent);

}
