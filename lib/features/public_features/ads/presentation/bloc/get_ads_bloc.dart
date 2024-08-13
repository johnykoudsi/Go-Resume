import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/data/data_sources/ads_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/data/repositories/ads_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/domain/entities/ad_entity.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/domain/use_cases/get_ads_usecase.dart';

part 'get_ads_event.dart';
part 'get_ads_state.dart';

class GetAdsBloc extends Bloc<GetAdsEvent, GetAdsState> {
  GetAdsBloc() : super(GetAdsInitial()) {
    final AdsRepoImpl adsRepoImpl = AdsRepoImpl(AdsDataSource(NetworkHelpers()));

    on<GetAllAdsEvent>((event, emit) async{
      emit(GetAdsInitial());

      GetAllAdsUseCase usecase = GetAllAdsUseCase(adsRepoImpl);

      final response = await usecase.call(event);

      if (response is List<Ad>) {
        emit(GetAllAdsDoneState(ads: response));
      } else {
        emit(GetAllAdsErrorState(helperResponse: response));
      }
    });
  }
}
