
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/domain/use_cases/get_all_countries_usecase.dart';

import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/entities/country_entity.dart';

part 'get_all_countries_event.dart';
part 'get_all_countries_state.dart';

class GetAllCountriesBloc extends Bloc<GetAllCountriesEvent, GetAllCountriesState> {
  GetAllCountriesBloc() : super(GetAllCountriesInitial()) {
    final CompanyProfileRepoImpl companyProfileRepoImpl = CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));

    on<GetCountriesEvent>((event, emit) async{
      emit(GetAllCountriesInitial());

      GetAllCountriesUseCase usecase = GetAllCountriesUseCase(companyProfileRepoImpl);

      final response = await usecase.call(event);

      if (response is WelcomeCountries) {
        emit(GetCountriesDoneState(countries: response.data));
      } else {
        emit(GetCountriesErrorState(helperResponse: response));
      }
    });
  }
}
