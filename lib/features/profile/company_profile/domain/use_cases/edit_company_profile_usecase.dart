
import '../../presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import '../repositories/company_profile_repo.dart';

class EditCompanyProfileUsecase {
  final CompanyProfileRepo companyProfileRepo;

  EditCompanyProfileUsecase(this.companyProfileRepo);

  Future call(UpdateCompanyProfileEvent updateCompanyProfileEvent) async {
    return await companyProfileRepo.edit(updateCompanyProfileEvent);
  }
}