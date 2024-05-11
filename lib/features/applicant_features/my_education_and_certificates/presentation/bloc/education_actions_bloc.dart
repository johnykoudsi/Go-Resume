
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_education_and_certificates/domain/use_cases/delete_education_usecase.dart';

import '../../data/data_sources/education_actions_datasource.dart';
import '../../data/repositories/education_actions_repo_impl.dart';
import '../../domain/use_cases/add_education_usecase.dart';

part 'education_actions_event.dart';
part 'education_actions_state.dart';

class EducationActionsBloc extends Bloc<EducationActionsEvent, EducationActionsState> {
  EducationActionsBloc() : super(EducationActionsInitial()) {
    final EducationActionsRepoImpl educationActionsRepoImpl = EducationActionsRepoImpl(EducationActionsDataSource(NetworkHelpers()));

    on<AddEducationEvent>((event, emit) async {
      emit(EducationActionsLoadingState());

      AddEducationUsecase useCase = AddEducationUsecase(educationActionsRepoImpl);

      final response = await useCase.call(event);

      emit(EducationActionsResponseState(helperResponse: response));

    });
    on<DeleteEducationEvent>((event, emit) async {
      emit(EducationActionsLoadingState());

      DeleteEducationUsecase useCase = DeleteEducationUsecase(educationActionsRepoImpl);

      final response = await useCase.call(event);

      emit(EducationActionsResponseState(helperResponse: response));

    });
  }
}
