import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/apply_for_job_usecase.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/is_applied_to_job_usecase.dart';

import '../../../data_sources/data_source/job_data_source.dart';
import '../../../data_sources/reposetries/job_repo_impl.dart';

part 'apply_for_job_event.dart';
part 'apply_for_job_state.dart';

class ApplyForJobBloc extends Bloc<ApplyForJobEvent, ApplyForJobState> {
  ApplyForJobBloc() : super(ApplyForJobInitial()) {
    final JobRepoImpl jobRepoImpl =
        JobRepoImpl(JobDataSource(NetworkHelpers()));
    ApplyForJobUseCase applyForJobUseCase = ApplyForJobUseCase(jobRepoImpl);
    IsAppliedToJobUseCase isAppliedToJobUseCase = IsAppliedToJobUseCase(jobRepoImpl);

    on<ApplyForJobApiEvent>((event, emit) async {
      emit(ApplyForJobLoadingState());
      final response = await applyForJobUseCase.call(event);
      emit(ApplyForJobResponseState(helperResponse: response));
      if(response is HelperResponse){
        if(response.servicesResponse == ServicesResponseStatues.success){
          emit(IsAppliedToJobResponseState(isAppliedTo: true));
        }
      }

    });
    on<IsAppliedToJobEvent>((event, emit) async {
      emit(ApplyForJobLoadingState());
      dynamic response;
      response = await isAppliedToJobUseCase.call(event);
      final isAppliedTo = json.decode(response.response)["data"]["is_applied_to"];
      emit(IsAppliedToJobResponseState(isAppliedTo: isAppliedTo));
      //  }
    });
  }
}
