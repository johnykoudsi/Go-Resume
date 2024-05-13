import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/use_cases/add_job_usecase.dart';

import '../../../data_sources/reposetries/job_repo_impl.dart';

part 'add_job_event.dart';
part 'add_job_state.dart';

class AddJobBloc extends Bloc<AddJobEvent, AddJobState> {
  static final JobRepoImpl jobRepoImpl = JobRepoImpl(JobDataSource(NetworkHelpers()));
  AddJobUseCase addJobUseCase = AddJobUseCase(jobRepoImpl);
  AddJobBloc() : super(AddJobInitialState()) {
    on<AddJobEvent>((event, emit) {

    });
    on<AddNewJobEvent>((event,emit) async{
      emit(AddJobLoadingState());
      final response = await addJobUseCase.call(event);

      emit(AddJobResponseState(helperResponse: response));
    });
  }
}
