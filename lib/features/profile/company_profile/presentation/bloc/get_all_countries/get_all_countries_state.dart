part of 'get_all_countries_bloc.dart';

abstract class GetAllCountriesState extends Equatable {
  const GetAllCountriesState();
}

class GetAllCountriesInitial extends GetAllCountriesState {
  @override
  List<Object> get props => [];
}
class GetCountriesDoneState extends GetAllCountriesState {
  GetCountriesDoneState({required this.countries});

  List<Country> countries;
  @override
  List<Object> get props => [countries];
}

class GetCountriesErrorState extends GetAllCountriesState {
  GetCountriesErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}