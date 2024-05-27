import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data/data_sources/company_profile_datasource.dart';
import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/use_cases/get_company_status_usecase.dart';
import '../../../domain/use_cases/toggle_company_usecase.dart';

part 'toggle_company_event.dart';
part 'toggle_company_state.dart';

class ToggleCompanyBloc extends Bloc<ToggleCompanyEvent, ToggleCompanyState> {
  ToggleCompanyBloc() : super(ToggleCompanyInitial()) {
    final CompanyProfileRepoImpl companyProfileRepoImpl =
    CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));
    ToggleCompanyUseCase toggleCompanyUseCase = ToggleCompanyUseCase(companyProfileRepoImpl);
    GetCompanyStatusUseCase getCompanyStatusUseCase =
    GetCompanyStatusUseCase(companyProfileRepoImpl);

    on<ToggleCompanyApiEvent>((event, emit) async {
      emit(ToggleCompanyLoadingState());
      dynamic isFavoriteResponse;
      isFavoriteResponse = await toggleCompanyUseCase.call(event);
      if (isFavoriteResponse is bool) {
        emit(ToggleCompanyLoadedState(isFavorite: isFavoriteResponse));
      }else{emit(ToggleCompanyErrorState(helperResponse: isFavoriteResponse));}
    });
    on<GetCompanyStatusEvent>((event, emit) async {
      emit(ToggleCompanyLoadingState());
      dynamic isFavoriteResponse;
      isFavoriteResponse = await getCompanyStatusUseCase.call(event);
      if (isFavoriteResponse is bool) {
        emit(ToggleCompanyLoadedState(isFavorite: isFavoriteResponse));
      }else{emit(ToggleCompanyErrorState(helperResponse: isFavoriteResponse));}
    });

  }
}
