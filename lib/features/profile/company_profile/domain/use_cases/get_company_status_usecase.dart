

import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';
import '../repositories/company_profile_repo.dart';

class GetCompanyStatusUseCase {
  final CompanyProfileRepo companyProfileRepo;

  GetCompanyStatusUseCase(this.companyProfileRepo);

  Future call(GetCompanyStatusEvent getCompanyStatusEvent) async {
    return await companyProfileRepo.getCompanyStatus(getCompanyStatusEvent);
  }

}