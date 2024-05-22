

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import '../../presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetAllCountriesUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetAllCountriesUseCase(this.companyProfileRepo);

  Future call(GetCountriesEvent getCountriesEvent) async {
    return await companyProfileRepo.getAllCountries(getCountriesEvent);
  }

}