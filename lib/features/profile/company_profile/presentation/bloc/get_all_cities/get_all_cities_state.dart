part of 'get_all_cities_bloc.dart';

abstract class GetAllCitiesState extends Equatable {
  const GetAllCitiesState();
}

class GetAllCitiesInitial extends GetAllCitiesState {
  @override
  List<Object> get props => [];
}
class GetCitiesDoneState extends GetAllCitiesState {
  GetCitiesDoneState({required this.cities});

  List<City> cities;
  @override
  List<Object> get props => [cities];
}
class GetCitiesLoadingState extends GetAllCitiesState {

  @override
  List<Object> get props => [];
}
class GetCitiesErrorState extends GetAllCitiesState {
  GetCitiesErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}