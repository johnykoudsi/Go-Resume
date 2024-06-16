import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/data/data_sources/get_user_features_dataSource.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/data/repositories/get_user_features_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/domain/use_cases/get_all_applicants_usecase.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';
part 'get_all_applicants_event.dart';
part 'get_all_applicants_state.dart';

class GetAllApplicantsBloc extends Bloc<GetAllApplicantsEvent, GetAllApplicantsState> {
  GetAllApplicantsBloc() : super(GetAllApplicantsLoadingState()) {
    final GetUserFeaturesRepoImpl getUserFeaturesRepoImpl =
    GetUserFeaturesRepoImpl(GetUserFeaturesDataSource(NetworkHelpers()));

    GetAllApplicantsUseCase getAllApplicantsUseCase = GetAllApplicantsUseCase(getUserFeaturesRepoImpl);

    on<GetAllApplicantsSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetAllApplicantsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetAllApplicantsLoadedState) {
          return currentState.applicantsList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getApplicants;

      event.searchFilter.page = getPage();

      getApplicants = await getAllApplicantsUseCase.call(event);

      if (getApplicants is List<User>) {
        if (getApplicants.isNotEmpty) {
          // copy previous state
          if (currentState is GetAllApplicantsLoadedState) {
            emit(currentState.copyWith(
                applicantsList: List.of(currentState.applicantsList)..addAll(getApplicants),
                hasReachedMax: getApplicants.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetAllApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: getApplicants.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetAllApplicantsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetAllApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetAllApplicantsErrorState(helperResponse: getApplicants));
      }
    });

    on<ChangeToLoadingAllApplicantsEvent>((event, emit) async {
      emit(GetAllApplicantsLoadingState());

      add(GetAllApplicantsSearchEvent(searchFilter: AllApplicantsSearchFilter(page: 1)));
    });
  }
}
