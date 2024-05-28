import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/reposetries/job_repo_impl.dart';

import '../../../../../utility/constant_logic_validation.dart';
import '../../../domain/use_cases/get_job_applicants_usecase.dart';

part 'get_job_applicants_event.dart';
part 'get_job_applicants_state.dart';

class GetJobApplicantsBloc extends Bloc<GetJobApplicantsEvent, GetJobApplicantsState> {
  GetJobApplicantsBloc() : super(GetJobApplicantsLoadingState()) {
    final JobRepoImpl jobRepoImpl =
    JobRepoImpl(JobDataSource(NetworkHelpers()));

    GetJobApplicantsUseCase getJobApplicantsUseCase = GetJobApplicantsUseCase(jobRepoImpl);

    on<GetJobApplicantsSearchEvent>((event, emit) async {
      final currentState = state;
      if (currentState is GetJobApplicantsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is GetJobApplicantsLoadedState) {
          return currentState.applicantsList.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      dynamic getApplicants;

      event.searchFilter.page = getPage();

      getApplicants = await getJobApplicantsUseCase.call(event);

      if (getApplicants is List<User>) {
        if (getApplicants.isNotEmpty) {
          // copy previous state
          if (currentState is GetJobApplicantsLoadedState) {
            emit(currentState.copyWith(
                applicantsList: List.of(currentState.applicantsList)..addAll(getApplicants),
                hasReachedMax: getApplicants.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(GetJobApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: getApplicants.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is GetJobApplicantsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(GetJobApplicantsLoadedState(
              applicantsList: getApplicants,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        emit(GetJobApplicantsErrorState(helperResponse: getApplicants));
      }
    });

    on<ChangeToLoadingJobApplicantsEvent>((event, emit) async {
      emit(GetJobApplicantsLoadingState());

      add(GetJobApplicantsSearchEvent(searchFilter: JobApplicantsSearchFilter(page: 1), jobId: event.jobId));
    });
  }
}
