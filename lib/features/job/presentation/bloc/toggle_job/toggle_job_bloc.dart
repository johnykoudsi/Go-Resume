import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/get_job_status_usecase.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/toggle_job_usecase.dart';

import '../../../data_sources/data_source/job_data_source.dart';
import '../../../data_sources/reposetries/job_repo_impl.dart';

part 'toggle_job_event.dart';
part 'toggle_job_state.dart';

class ToggleJobBloc extends Bloc<ToggleJobEvent, ToggleJobState> {
  ToggleJobBloc() : super(ToggleJobInitial()) {
    final JobRepoImpl jobRepoImpl =
        JobRepoImpl(JobDataSource(NetworkHelpers()));
    ToggleJobUseCase toggleJobUseCase = ToggleJobUseCase(jobRepoImpl);
    GetJobStatusUseCase getJobStatusUseCase = GetJobStatusUseCase(jobRepoImpl);

    on<ToggleJobApiEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isSavedResponse;
      isSavedResponse = await toggleJobUseCase.call(event);
      if (isSavedResponse is bool) {
        emit(ToggleJobLoadedState(isSaved: isSavedResponse));
      } else {
        emit(ToggleJobErrorState(helperResponse: isSavedResponse));
      }
    });
    on<GetJobStatusEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isSavedResponse;
      isSavedResponse = await getJobStatusUseCase.call(event);
      // if (isSavedResponse is int) {
      bool isSaved = isSavedResponse == 0 ? false : true;
      emit(ToggleJobLoadedState(isSaved: false));
      //  }
    });
  }
}
