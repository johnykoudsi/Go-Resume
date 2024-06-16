

import '../../presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetFavoriteCompaniesUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetFavoriteCompaniesUseCase(this.companyProfileRepo);

  Future call(GetFavoriteCompaniesSearchEvent getFavoriteCompaniesSearchEvent) async {
    return await companyProfileRepo.getFavoriteCompanies(getFavoriteCompaniesSearchEvent);
  }

}