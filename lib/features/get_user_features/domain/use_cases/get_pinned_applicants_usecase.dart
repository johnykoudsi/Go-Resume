

import 'package:smart_recruitment_flutter_user/features/get_user_features/domain/repositories/get_user_features_repo.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_pinned_applicants/get_pinned_applicants_bloc.dart';

class GetPinnedApplicantsUseCase {
  final GetUserFeaturesRepo userFeaturesRepo;

  GetPinnedApplicantsUseCase(this.userFeaturesRepo);

  Future call(GetPinnedApplicantsSearchEvent getPinnedApplicantsSearchEvent) async {
    return await userFeaturesRepo.getPinnedApplicants(getPinnedApplicantsSearchEvent);
  }
}