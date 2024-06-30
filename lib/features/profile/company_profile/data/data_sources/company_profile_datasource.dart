import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/domain/entities/country_entity.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';

import '../../domain/entities/City_entity.dart';
import '../../presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import '../../presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import '../../presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';


class CompanyProfileDataSource {
  CompanyProfileDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future toggleCompany(ToggleCompanyApiEvent toggleCompanyApiEvent) async {

    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.favoriteCompanyToggle(id: toggleCompanyApiEvent.id),
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isFavorite = json.decode(helperResponse.response)["data"]["is_favorite"];
        return isFavorite;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
  Future getCompanyStatus({
    required GetCompanyStatusEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.isCompanyFavorite(id: event.id),
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isFavorite = json.decode(helperResponse.response)["data"]["is_favorite"];
        return isFavorite;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future addPolicyDataSource(AddPolicyEvent addPolicyEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addPolicy,
      body: json.encode(addPolicyEvent.toJson()),
    );
    return helperResponse;
  }
  Future deletePolicyDataSource(DeletePolicyEvent deletePolicyEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deletePolicy(id: deletePolicyEvent.id),
    );
    return helperResponse;
  }

  Future getAllCompanyDataSource(GetAllCompanySearchEvent getAllCompanySearchEvent) async {
    String queryString =
        Uri(queryParameters: getAllCompanySearchEvent.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getCompanies}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return  List<User>.from(data.map((x) => User.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
  Future getFavoriteCompaniesDataSource(GetFavoriteCompaniesSearchEvent getFavoriteCompaniesSearchEvent) async {
    String queryString =
        Uri(queryParameters: getFavoriteCompaniesSearchEvent.searchFilter.toJson()).query;

    String urlWithParams = "${EndPoints.getFavoriteCompanies}?$queryString";

    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: urlWithParams,
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return  List<User>.from(data.map((x) => User.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future editCompanyProfileDataSource(UpdateCompanyProfileEvent updateCompanyProfileEvent) async {
    if(updateCompanyProfileEvent.profileImage != null ){
      HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
          url: EndPoints.updateCompanyProfile,
          useUserToken: true,
          body: updateCompanyProfileEvent.toMapBody(),
          files: updateCompanyProfileEvent.profileImage!,
          keyName: 'profile_image'
      );
      return helperResponse;
    }
    else if(updateCompanyProfileEvent.coverImage != null ){
      HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
          url: EndPoints.updateCompanyProfile,
          useUserToken: true,
          body: updateCompanyProfileEvent.toMapBody(),
          files: updateCompanyProfileEvent.coverImage!,
          keyName: 'cover_image'
      );
      return helperResponse;
    }
    else{
      HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
        useUserToken: true,
        url: EndPoints.updateCompanyProfile,
        body: json.encode(updateCompanyProfileEvent.toMapBody()),
      );
      return helperResponse;
    }
  }

  Future getCountries({
    required GetCountriesEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getCountries,
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        return welcomeCountriesEntityFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError,
        );
      }
    }
    return helperResponse;
  }

  Future getCities({
    required GetCitiesEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getCities(countryCode: event.countryCode),
      useUserToken: true,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        return welcomeCitiesFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError,
        );
      }
    }
    return helperResponse;
  }
}
