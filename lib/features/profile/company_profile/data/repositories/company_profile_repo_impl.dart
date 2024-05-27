
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';

import '../../domain/repositories/company_profile_repo.dart';


class CompanyProfileRepoImpl extends CompanyProfileRepo {
  CompanyProfileRepoImpl(this.companyProfileDataSource);

  CompanyProfileDataSource companyProfileDataSource;

  @override
  Future addPolicy(AddPolicyEvent addPolicyEvent) async {
    return await companyProfileDataSource.addPolicyDataSource(addPolicyEvent);
  }

  @override
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent) async{
    return await companyProfileDataSource.deletePolicyDataSource(deletePolicyEvent);

  }

  @override
  Future getAllCompany(GetAllCompanySearchEvent getAllCompanySearchEvent) async {
    return await companyProfileDataSource.getAllCompanyDataSource(getAllCompanySearchEvent);
  }

  @override
  Future edit(UpdateCompanyProfileEvent updateCompanyProfileEvent) async{
    return await companyProfileDataSource.editCompanyProfileDataSource(updateCompanyProfileEvent);

  }

  @override
  Future getAllCountries(GetCountriesEvent getCountriesEvent) async{
    return await companyProfileDataSource.getCountries(event: getCountriesEvent);
  }

  @override
  Future getAllCities(GetCitiesEvent getCitiesEvent) async{
    return await companyProfileDataSource.getCities(event: getCitiesEvent);

  }

  @override
  Future getFavoriteCompanies(GetFavoriteCompaniesSearchEvent getFavoriteCompaniesSearchEvent) async{
    return await companyProfileDataSource.getFavoriteCompaniesDataSource(getFavoriteCompaniesSearchEvent);

  }

  @override
  Future toggleCompany(ToggleCompanyApiEvent toggleCompanyApiEvent)async {
    return await companyProfileDataSource.toggleCompany(toggleCompanyApiEvent);

  }

  @override
  Future getCompanyStatus(GetCompanyStatusEvent getCompanyStatusEvent) async{
    return await companyProfileDataSource.getCompanyStatus(event: getCompanyStatusEvent);

  }


}