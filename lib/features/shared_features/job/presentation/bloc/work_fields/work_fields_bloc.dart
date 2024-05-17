import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data_sources/data_source/job_data_source.dart';
import '../../../data_sources/reposetries/job_repo_impl.dart';
import '../../../domain/entities/work_field_entity.dart';
import '../../../domain/use_cases/get_work_fields_usecase.dart';

part 'work_fields_event.dart';
part 'work_fields_state.dart';

class WorkFieldsBloc extends Bloc<WorkFieldsEvent, WorkFieldsState> {
  WorkFieldsBloc() : super(WorkFieldsInitial()) {
    final JobRepoImpl jobRepoImpl = JobRepoImpl(JobDataSource(NetworkHelpers()));

    on<GetWorkFieldsEvent>((event, emit) async{
      emit(WorkFieldsInitial());

      GetWorkFieldsUseCase usecase = GetWorkFieldsUseCase(jobRepoImpl);

      final response = await usecase.call(event);

      if (response is WelcomeWorkFields) {
        emit(WorkFieldsDoneState(workFields: response.data));
      } else {
        emit(WorkFieldsErrorState(helperResponse: response));
      }
    });
  }
}
