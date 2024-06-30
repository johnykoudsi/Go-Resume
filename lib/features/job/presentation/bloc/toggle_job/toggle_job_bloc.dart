import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/get_job_status_usecase.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/toggle_job_status_usecase.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/toggle_job_usecase.dart';

import '../../../data_sources/data_source/job_data_source.dart';
import '../../../data_sources/reposetries/job_repo_impl.dart';
import '../../../domain/use_cases/get_job_closed_status_usecase.dart';

part 'toggle_job_event.dart';
part 'toggle_job_state.dart';

class ToggleJobBloc extends Bloc<ToggleJobEvent, ToggleJobState> {
  ToggleJobBloc() : super(ToggleJobInitial()) {
    final JobRepoImpl jobRepoImpl =
        JobRepoImpl(JobDataSource(NetworkHelpers()));
    ToggleJobUseCase toggleJobUseCase = ToggleJobUseCase(jobRepoImpl);
    ToggleJobStatusUseCase toggleJobStatusUseCase = ToggleJobStatusUseCase(jobRepoImpl);
    GetJobStatusUseCase getJobStatusUseCase = GetJobStatusUseCase(jobRepoImpl);
    GetJobClosedStatusUseCase getJobClosedStatusUseCase = GetJobClosedStatusUseCase(jobRepoImpl);

    on<ToggleJobApiEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isSavedResponse;
      isSavedResponse = await toggleJobUseCase.call(event);
      emit(ToggleJobLoadedState(isSaved: isSavedResponse));
    });
    on<ToggleJobStatusApiEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isClosedResponse;
      isClosedResponse = await toggleJobStatusUseCase.call(event);
      bool isClosed = isClosedResponse == 0 ? false : true;
      emit(ToggleJobLoadedState(isSaved: isClosed));
    });
    on<GetJobStatusEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isSavedResponse;
      isSavedResponse = await getJobStatusUseCase.call(event);
      bool isSaved = isSavedResponse == 0 ? false : true;
      emit(ToggleJobLoadedState(isSaved: isSaved));
    });
    on<GetJobClosedStatusEvent>((event, emit) async {
      emit(ToggleJobLoadingState());
      dynamic isClosedResponse;
      isClosedResponse = await getJobClosedStatusUseCase.call(event);
      bool isClosed = isClosedResponse == 0 ? false : true;
      emit(ToggleJobLoadedState(isSaved: isClosed));
    });
  }
}
