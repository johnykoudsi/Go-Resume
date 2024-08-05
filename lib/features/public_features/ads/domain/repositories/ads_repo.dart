
import 'package:smart_recruitment_flutter_user/features/public_features/ads/presentation/bloc/get_ads_bloc.dart';

abstract class AdsRepo {

  Future getAllAds(GetAllAdsEvent event);

}