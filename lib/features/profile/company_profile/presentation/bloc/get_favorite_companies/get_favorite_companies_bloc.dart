import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../../../../utility/constant_logic_validation.dart';
import '../../../data/data_sources/company_profile_datasource.dart';
import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/use_cases/get_favorite_companies_usecase.dart';

part 'get_favorite_companies_event.dart';
part 'get_favorite_companies_state.dart';

class GetFavoriteCompaniesBloc extends Bloc<GetFavoriteCompaniesEvent, GetFavoriteCompaniesState> {
  GetFavoriteCompaniesBloc() : super(GetFavoriteCompaniesLoadingState()) {
    final CompanyProfileRepoImpl companyRepoImpl =
    CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));

    GetFavoriteCompaniesUseCase getFavoriteCompaniesUseCase = GetFavoriteCompaniesUseCase(companyRepoImpl);

    on<GetFavoriteCompaniesSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetFavoriteCompaniesLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetFavoriteCompaniesLoadedState) {
          return currentState.companyList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getCompany;

      event.searchFilter.page = getPage();

      getCompany = await getFavoriteCompaniesUseCase.call(event);

      if (getCompany is List<User>) {
        if (getCompany.isNotEmpty) {
          // copy previous state
          if (currentState is GetFavoriteCompaniesLoadedState) {
            emit(currentState.copyWith(
                companyList: List.of(currentState.companyList)..addAll(getCompany),
                hasReachedMax: getCompany.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetFavoriteCompaniesLoadedState(
              companyList: getCompany,
              hasReachedMax: getCompany.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetFavoriteCompaniesLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetFavoriteCompaniesLoadedState(
              companyList: getCompany,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetFavoriteCompaniesErrorState(helperResponse: getCompany));
      }
    });

    on<ChangeToLoadingFavoriteCompaniesEvent>((event, emit) async {
      emit(GetFavoriteCompaniesLoadingState());

      add(GetFavoriteCompaniesSearchEvent(searchFilter: FavoriteCompaniesSearchFilter(page: 1)));
    });
  }
}
