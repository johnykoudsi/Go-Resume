import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/reposetries/job_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/get_all_jobs_usecase.dart';
import 'package:smart_recruitment_flutter_user/utility/constant_logic_validation.dart';

part 'get_all_jobs_event.dart';
part 'get_all_jobs_state.dart';

class GetAllJobsBloc extends Bloc<GetAllJobsEvent, GetAllJobsState> {
  GetAllJobsBloc() : super(GetAllJobsLoadingState()) {
    final JobRepoImpl jobRepoImpl =
        JobRepoImpl(JobDataSource(NetworkHelpers()));

    GetAllJobsUseCase getAllJobsUseCase = GetAllJobsUseCase(jobRepoImpl);

    on<GetAllJobsSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetAllJobsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetAllJobsLoadedState) {
          return currentState.jobList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getJobs;

      event.searchFilter.page = getPage();

      getJobs = await getAllJobsUseCase.call(event);

      if (getJobs is List<JobEntity>) {
        if (getJobs.isNotEmpty) {
          // copy previous state
          if (currentState is GetAllJobsLoadedState) {
            emit(currentState.copyWith(
                jobList: List.of(currentState.jobList)..addAll(getJobs),
                hasReachedMax: getJobs.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetAllJobsLoadedState(
              jobList: getJobs,
              hasReachedMax: getJobs.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetAllJobsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetAllJobsLoadedState(
              jobList: getJobs,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetAllJobsErrorState(helperResponse: getJobs));
      }
    });

    on<ChangeToLoadingAllJobsEvent>((event, emit) async {
      emit(GetAllJobsLoadingState());

      add(GetAllJobsSearchEvent(
          searchFilter:
              event.searchFilter?.copyWith(page: 1) ?? AllJobsSearchFilter()));
    });
  }
}
