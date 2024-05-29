import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/data/data_sources/get_user_features_dataSource.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/data/repositories/get_user_features_repo_impl.dart';

import '../../../../../utility/constant_logic_validation.dart';
import '../../../domain/use_cases/get_pinned_applicants_usecase.dart';

part 'get_pinned_applicants_event.dart';
part 'get_pinned_applicants_state.dart';

class GetPinnedApplicantsBloc extends Bloc<GetPinnedApplicantsEvent, GetPinnedApplicantsState> {
  GetPinnedApplicantsBloc() : super(GetPinnedApplicantsLoadingState()) {
    final GetUserFeaturesRepoImpl getUserFeaturesRepoImpl =
    GetUserFeaturesRepoImpl(GetUserFeaturesDataSource(NetworkHelpers()));

    GetPinnedApplicantsUseCase getPinnedApplicantsUseCase = GetPinnedApplicantsUseCase(getUserFeaturesRepoImpl);

    on<GetPinnedApplicantsSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetPinnedApplicantsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetPinnedApplicantsLoadedState) {
          return currentState.applicantsList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getApplicants;

      event.searchFilter.page = getPage();

      getApplicants = await getPinnedApplicantsUseCase.call(event);

      if (getApplicants is List<User>) {
        if (getApplicants.isNotEmpty) {
          // copy previous state
          if (currentState is GetPinnedApplicantsLoadedState) {
            emit(currentState.copyWith(
                applicantsList: List.of(currentState.applicantsList)..addAll(getApplicants),
                hasReachedMax: getApplicants.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetPinnedApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: getApplicants.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetPinnedApplicantsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetPinnedApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetPinnedApplicantsErrorState(helperResponse: getApplicants));
      }
    });

    on<ChangeToLoadingPinnedApplicantsEvent>((event, emit) async {
      emit(GetPinnedApplicantsLoadingState());

      add(GetPinnedApplicantsSearchEvent(searchFilter: PinnedApplicantsSearchFilter(page: 1)));
    });
  }
}
