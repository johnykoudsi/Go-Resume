import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../../../core/enums.dart';
import '../../../data_sources/data_source/job_data_source.dart';
import '../../../data_sources/reposetries/job_repo_impl.dart';
import '../../../domain/use_cases/delete_job_usecase.dart';
import '../../../domain/use_cases/edit_job_usecase.dart';
import '../../../domain/use_cases/reject_applicant_usecase.dart';

part 'edit_job_event.dart';
part 'edit_job_state.dart';

class EditJobBloc extends Bloc<EditJobEvent, EditJobState> {
  static final JobRepoImpl jobRepoImpl = JobRepoImpl(JobDataSource(NetworkHelpers()));
  EditJobUseCase editJobUseCase = EditJobUseCase(jobRepoImpl);
  EditJobBloc() : super(EditJobInitialState()) {
    on<EditMyJobEvent>((event,emit) async{
      emit(EditJobLoadingState());
      final response = await editJobUseCase.call(event);

      emit(EditJobResponseState(helperResponse: response));
    });
    on<DeleteJobEvent>((event, emit) async {
      emit(EditJobLoadingState());

      DeleteJobUseCase useCase = DeleteJobUseCase(jobRepoImpl);

      final response = await useCase.call(event);

      emit(EditJobResponseState(helperResponse: response));

    });
    on<RejectApplicantEvent>((event, emit) async {
      emit(EditJobLoadingState());

      RejectApplicantUseCase useCase = RejectApplicantUseCase(jobRepoImpl);

      final response = await useCase.call(event);

      emit(EditJobResponseState(helperResponse: response));

    });
  }

}
