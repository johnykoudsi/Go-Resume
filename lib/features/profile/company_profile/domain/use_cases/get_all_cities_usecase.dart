

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetAllCitiesUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetAllCitiesUseCase(this.companyProfileRepo);

  Future call(GetCitiesEvent getCitiesEvent) async {
    return await companyProfileRepo.getAllCities(getCitiesEvent);
  }

}