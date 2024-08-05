part of 'get_ads_bloc.dart';

sealed class GetAdsEvent extends Equatable {
  const GetAdsEvent();
}
class GetAllAdsEvent extends GetAdsEvent{
  @override
  List<Object?> get props => [];
}