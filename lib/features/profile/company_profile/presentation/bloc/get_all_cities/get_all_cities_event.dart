part of 'get_all_cities_bloc.dart';

abstract class GetAllCitiesEvent extends Equatable {
  const GetAllCitiesEvent();
}
class GetCitiesEvent extends GetAllCitiesEvent {
  GetCitiesEvent({required this.countryCode});

  String countryCode;

  @override
  List<Object?> get props => [countryCode];
}
