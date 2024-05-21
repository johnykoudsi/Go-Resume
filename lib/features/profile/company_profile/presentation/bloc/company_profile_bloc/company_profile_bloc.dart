import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/data/data_sources/user_datasource.dart';
import 'package:smart_recruitment_core/features/auth/data/repositories/user_repo_impl.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data/data_sources/company_profile_datasource.dart';
import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/use_cases/edit_company_profile_usecase.dart';

part 'company_profile_event.dart';
part 'company_profile_state.dart';

class CompanyProfileBloc extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  static final CompanyProfileRepoImpl companyProfileRepoImpl = CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));
  static final UserRepoImpl userRepoImpl = UserRepoImpl(UserDataSource(NetworkHelpers()));
  EditCompanyProfileUsecase editCompanyProfileUsecase = EditCompanyProfileUsecase(companyProfileRepoImpl);

  CompanyProfileBloc() : super(CompanyProfileInitial()) {
    on<CompanyProfileEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<UpdateCompanyProfileEvent>((event, emit) async {
      emit(CompanyProfileLoading());

      final response = await editCompanyProfileUsecase.call(event);

      emit(CompanyProfileResponseState(helperResponse: response));

    });
  }
}
