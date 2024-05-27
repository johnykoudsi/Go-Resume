

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';
import '../../presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import '../repositories/company_profile_repo.dart';

class ToggleCompanyUseCase {
  final CompanyProfileRepo companyProfileRepo;

  ToggleCompanyUseCase(this.companyProfileRepo);

  Future call(ToggleCompanyApiEvent toggleCompanyApiEvent) async {
    return await companyProfileRepo.toggleCompany(toggleCompanyApiEvent);
  }

}