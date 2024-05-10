import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/data/data_sources/experience_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/data/repositories/experience_actions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/domain/use_cases/add_experience_usecase.dart';

part 'experience_actions_event.dart';
part 'experience_actions_state.dart';

class ExperienceActionsBloc extends Bloc<ExperienceActionsEvent, ExperienceActionsState> {

  ExperienceActionsBloc() : super(ExperienceActionsInitial()) {
    final ExperienceActionsRepoImpl experienceActionsRepoImpl = ExperienceActionsRepoImpl(ExperienceActionsDataSource(NetworkHelpers()));

    on<AddExperienceEvent>((event, emit) async {
      emit(ExperienceActionsLoadingState());

      AddExperienceUsecase useCase = AddExperienceUsecase(experienceActionsRepoImpl);

      final response = await useCase.call(event);

      emit(ExperienceActionsResponseState(helperResponse: response));

    });
  }
}