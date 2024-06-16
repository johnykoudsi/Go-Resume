import 'package:smart_recruitment_flutter_user/features/get_user_features/data/data_sources/get_user_features_dataSource.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/domain/repositories/get_user_features_repo.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_All_applicants/get_all_applicants_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/presentation/bloc/get_pinned_applicants/get_pinned_applicants_bloc.dart';


class GetUserFeaturesRepoImpl extends GetUserFeaturesRepo {
  GetUserFeaturesDataSource getUserFeaturesDataSource;
  GetUserFeaturesRepoImpl(this.getUserFeaturesDataSource);

  @override
  Future getPinnedApplicants(GetPinnedApplicantsSearchEvent getPinnedApplicantsSearchEvent) {
    return getUserFeaturesDataSource.getPinnedApplicants(event: getPinnedApplicantsSearchEvent);

  }

  @override
  Future getAllApplicants(GetAllApplicantsSearchEvent getAllApplicantsSearchEvent) {
    return getUserFeaturesDataSource.getAllApplicants(event: getAllApplicantsSearchEvent);

  }







}
