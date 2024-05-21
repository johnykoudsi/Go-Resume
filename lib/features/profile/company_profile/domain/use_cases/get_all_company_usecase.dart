

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetAllCompanyUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetAllCompanyUseCase(this.companyProfileRepo);

  Future call(GetAllCompanySearchEvent getAllCompanySearchEvent) async {
    return await companyProfileRepo.getAllCompany(getAllCompanySearchEvent);
  }

}