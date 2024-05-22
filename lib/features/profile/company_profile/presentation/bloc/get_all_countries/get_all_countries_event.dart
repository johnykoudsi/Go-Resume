part of 'get_all_countries_bloc.dart';

abstract class GetAllCountriesEvent extends Equatable {
  const GetAllCountriesEvent();
}
class GetCountriesEvent extends GetAllCountriesEvent{
  @override
  List<Object?> get props => [];
}