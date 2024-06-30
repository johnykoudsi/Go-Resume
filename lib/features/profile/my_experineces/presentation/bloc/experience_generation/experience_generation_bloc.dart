import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/data/data_sources/experience_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/data/repositories/experience_actions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/domain/use_cases/experience_generation_usecase.dart';

part 'experience_generation_event.dart';
part 'experience_generation_state.dart';

class ExperienceGenerationBloc
    extends Bloc<ExperienceGenerationEvent, ExperienceGenerationState> {
  final ExperienceActionsRepoImpl experienceActionsRepoImpl =
      ExperienceActionsRepoImpl(ExperienceActionsDataSource(NetworkHelpers()));

  ExperienceGenerationBloc() : super(ExperienceGenerationInitialState()) {
    ExperienceGenerationUsecase experienceGenerationUsecase =
        ExperienceGenerationUsecase(experienceActionsRepoImpl);

    on<PostExperienceGenerationEvent>((event, emit) async {
      emit(ExperienceGenerationLoadingState());

      final response = await experienceGenerationUsecase.call(event);

      if (response is String) {
        emit(ExperienceGenerationDoneState(generation: response));
      } else {
        emit(ExperienceGenerationErrorState(response: response));
      }
    });
  }
}
