part of 'get_ads_bloc.dart';

sealed class GetAdsState extends Equatable {
  const GetAdsState();
}

final class GetAdsInitial extends GetAdsState {
  @override
  List<Object> get props => [];
}
class GetAllAdsDoneState extends GetAdsState {
  GetAllAdsDoneState({required this.ads});

  List<Ad> ads;
  @override
  List<Object> get props => [ads];
}

class GetAllAdsErrorState extends GetAdsState {
  GetAllAdsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}