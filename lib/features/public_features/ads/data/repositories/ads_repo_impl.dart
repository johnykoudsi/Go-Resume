
import 'package:smart_recruitment_flutter_user/features/public_features/ads/domain/repositories/ads_repo.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/presentation/bloc/get_ads_bloc.dart';

import '../data_sources/ads_data_source.dart';

class AdsRepoImpl extends AdsRepo {
  AdsRepoImpl(this.adsDataSource);
  AdsDataSource adsDataSource;

  @override
  Future getAllAds(GetAllAdsEvent event) async{
    return await adsDataSource.getAdsDataSource(event: event);

  }

}