import 'package:bloc/bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/repositories/company_profile_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/domain/use_cases/get_all_company_usecase.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';
import 'package:equatable/equatable.dart';
part 'get_all_company_event.dart';
part 'get_all_company_state.dart';

class GetAllCompanyBloc extends Bloc<GetAllCompanyEvent, GetAllCompanyState> {
  GetAllCompanyBloc() : super(GetAllCompanyLoadingState()) {
    final CompanyProfileRepoImpl companyRepoImpl =
    CompanyProfileRepoImpl(CompanyProfileDataSource(NetworkHelpers()));

    GetAllCompanyUseCase getAllCompanyUseCase = GetAllCompanyUseCase(companyRepoImpl);

    on<GetAllCompanySearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetAllCompanyLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetAllCompanyLoadedState) {
          return currentState.companyList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getCompany;

      event.searchFilter.page = getPage();

      getCompany = await getAllCompanyUseCase.call(event);

      if (getCompany is List<User>) {
        if (getCompany.isNotEmpty) {
          // copy previous state
          if (currentState is GetAllCompanyLoadedState) {
            emit(currentState.copyWith(
                companyList: List.of(currentState.companyList)..addAll(getCompany),
                hasReachedMax: getCompany.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetAllCompanyLoadedState(
              companyList: getCompany,
              hasReachedMax: getCompany.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetAllCompanyLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetAllCompanyLoadedState(
              companyList: getCompany,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetAllCompanyErrorState(helperResponse: getCompany));
      }
    });

    on<ChangeToLoadingAllCompanyEvent>((event, emit) async {
      emit(GetAllCompanyLoadingState());

      add(GetAllCompanySearchEvent(searchFilter: AllCompanySearchFilter(page: 1)));
    });
  }
}
