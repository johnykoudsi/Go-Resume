import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/data/data_sources/education_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/data/repositories/education_actions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/domain/use_cases/experience_generation_usecase.dart';

part 'education_generation_event.dart';
part 'education_generation_state.dart';

class EducationGenerationBloc
    extends Bloc<EducationGenerationEvent, EducationGenerationState> {
  final EducationActionsRepoImpl educationActionsRepoImpl =
      EducationActionsRepoImpl(EducationActionsDataSource(NetworkHelpers()));

  EducationGenerationBloc() : super(EducationGenerationInitialState()) {
    EducationGenerationUsecase educationGenerationUsecase =
        EducationGenerationUsecase(educationActionsRepoImpl);

    on<PostEducationGenerationEvent>((event, emit) async {
      emit(EducationGenerationLoadingState());

      await Future.delayed(const Duration(seconds: 5));
      final response = await educationGenerationUsecase.call(event);

      if (response is String) {
        emit(EducationGenerationDoneState(generation: response));
      } else {
        emit(EducationGenerationErrorState(response: response));
      }
    });
  }
}
