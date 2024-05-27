import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';

import '../../presentation/bloc/get_all_cities/get_all_cities_bloc.dart';


abstract class CompanyProfileRepo{
  Future addPolicy(AddPolicyEvent addPolicyEvent);
  Future deletePolicy(DeletePolicyEvent deletePolicyEvent);
  Future getAllCompany(GetAllCompanySearchEvent getAllCompanySearchEvent);
  Future edit(UpdateCompanyProfileEvent updateCompanyProfileEvent);
  Future getAllCountries(GetCountriesEvent getCountriesEvent);
  Future getAllCities(GetCitiesEvent getCitiesEvent);
  Future getFavoriteCompanies(GetFavoriteCompaniesSearchEvent getFavoriteCompaniesSearchEvent);
  Future toggleCompany(ToggleCompanyApiEvent toggleCompanyApiEvent);
  Future getCompanyStatus(GetCompanyStatusEvent getCompanyStatusEvent);

}