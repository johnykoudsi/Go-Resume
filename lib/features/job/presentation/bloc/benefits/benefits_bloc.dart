import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/reposetries/job_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/benefits_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/get_benefits_usecase.dart';

part 'benefits_event.dart';
part 'benefits_state.dart';

class BenefitsBloc extends Bloc<BenefitsEvent, BenefitsState> {
  BenefitsBloc() : super(BenefitsInitial()) {
    final JobRepoImpl jobRepoImpl = JobRepoImpl(JobDataSource(NetworkHelpers()));

    on<GetBenefitsEvent>((event, emit) async{
      emit(BenefitsInitial());

      GetBenefitsUseCase usecase = GetBenefitsUseCase(jobRepoImpl);

      final response = await usecase.call(event);

      if (response is WelcomeBenefits) {
        emit(BenefitsDoneState(benefits: response.data));
      } else {
        emit(BenefitsErrorState(helperResponse: response));
      }
    });
  }
}
