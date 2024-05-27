import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/reposetries/job_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';

import '../../../domain/use_cases/get_saved_jobs_usecase.dart';

part 'get_saved_jobs_event.dart';
part 'get_saved_jobs_state.dart';

class GetSavedJobsBloc extends Bloc<GetSavedJobsEvent, GetSavedJobsState> {
  GetSavedJobsBloc() : super(GetSavedJobsLoadingState()) {
    final JobRepoImpl jobRepoImpl =
    JobRepoImpl(JobDataSource(NetworkHelpers()));

    GetSavedJobsUseCase getSavedJobsUseCase = GetSavedJobsUseCase(jobRepoImpl);

    on<GetSavedJobsSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetSavedJobsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetSavedJobsLoadedState) {
          return currentState.jobList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getJobs;

      event.searchFilter.page = getPage();

      getJobs = await getSavedJobsUseCase.call(event);

      if (getJobs is List<JobEntity>) {
        if (getJobs.isNotEmpty) {
          // copy previous state
          if (currentState is GetSavedJobsLoadedState) {
            emit(currentState.copyWith(
                jobList: List.of(currentState.jobList)..addAll(getJobs),
                hasReachedMax: getJobs.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetSavedJobsLoadedState(
              jobList: getJobs,
              hasReachedMax: getJobs.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetSavedJobsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetSavedJobsLoadedState(
              jobList: getJobs,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetSavedJobsErrorState(helperResponse: getJobs));
      }
    });

    on<ChangeToLoadingSavedJobsEvent>((event, emit) async {
      emit(GetSavedJobsLoadingState());

      add(GetSavedJobsSearchEvent(searchFilter: SavedJobsSearchFilter(page: 1)));
    });
  }
}
