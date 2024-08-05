import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/domain/entities/ad_entity.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/domain/entities/my_notifications_entity.dart';

import '../../presentation/bloc/get_ads_bloc.dart';



class AdsDataSource {
  AdsDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;
  Future getAdsDataSource({required GetAllAdsEvent event}) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getAllAds,
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = adEntityFromJson(helperResponse.response);
        return  data.data;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }


}
