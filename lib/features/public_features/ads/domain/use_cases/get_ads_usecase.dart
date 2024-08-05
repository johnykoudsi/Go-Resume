import '../../presentation/bloc/get_ads_bloc.dart';
import '../repositories/ads_repo.dart';

class GetAllAdsUseCase {
  final AdsRepo allAdsRepo;

  GetAllAdsUseCase(this.allAdsRepo);

  Future call(GetAllAdsEvent event) async {
    return await allAdsRepo.getAllAds(event);
  }
}
