

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import '../../presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetFavoriteCompaniesUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetFavoriteCompaniesUseCase(this.companyProfileRepo);

  Future call(GetFavoriteCompaniesSearchEvent getFavoriteCompaniesSearchEvent) async {
    return await companyProfileRepo.getFavoriteCompanies(getFavoriteCompaniesSearchEvent);
  }

}