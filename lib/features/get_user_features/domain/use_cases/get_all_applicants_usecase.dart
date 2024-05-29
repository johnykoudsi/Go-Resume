

import 'package:smart_recruitment_flutter_user/features/get_user_features/domain/repositories/get_user_features_repo.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_All_applicants/get_All_applicants_bloc.dart';

import '../../presentation/bloc/get_all_applicants/get_all_applicants_bloc.dart';

class GetAllApplicantsUseCase {
  final GetUserFeaturesRepo userFeaturesRepo;

  GetAllApplicantsUseCase(this.userFeaturesRepo);

  Future call(GetAllApplicantsSearchEvent getAllApplicantsSearchEvent) async {
    return await userFeaturesRepo.getAllApplicants(getAllApplicantsSearchEvent);
  }
}