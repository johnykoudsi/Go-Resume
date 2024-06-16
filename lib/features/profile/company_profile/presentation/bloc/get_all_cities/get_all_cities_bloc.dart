
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data/data_sources/company_profile_datasource.dart';
import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/entities/City_entity.dart';
import '../../../domain/use_cases/get_all_cities_usecase.dart';

part 'get_all_cities_event.dart';
part 'get_all_cities_state.dart';

class GetAllCitiesBloc extends Bloc<GetAllCitiesEvent, GetAllCitiesState> {
  GetAllCitiesBloc() : super(GetAllCitiesInitial()) {
    final CompanyProfileRepoImpl companyProfileRepoImpl = CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));

    on<GetCitiesEvent>((event, emit) async{
      emit(GetCitiesLoadingState());

      GetAllCitiesUseCase usecase = GetAllCitiesUseCase(companyProfileRepoImpl);

      final response = await usecase.call(event);

      if (response is WelcomeCities) {
        emit(GetCitiesDoneState(cities: response.data.data));
      } else {
        emit(GetCitiesErrorState(helperResponse: response));
      }
    });
  }
}
