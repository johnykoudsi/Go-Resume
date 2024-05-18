import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/data/data_sources/skill_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/data/repositories/skill_actions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/domain/use_cases/add_skill_usecase.dart';
part 'skill_actions_event.dart';
part 'skill_actions_state.dart';

class SkillActionsBloc
    extends Bloc<SkillActionsEvent, SkillActionsState> {
  SkillActionsBloc() : super(SkillActionsInitial()) {
    final SkillActionsRepoImpl skillActionsRepoImpl =
        SkillActionsRepoImpl(
            SkillActionsDataSource(NetworkHelpers()));

    on<AddSkillEvent>((event, emit) async {
      emit(SkillActionsLoadingState());

      AddSkillUsecase useCase =
          AddSkillUsecase(skillActionsRepoImpl);

      final response = await useCase.call(event);

      emit(SkillActionsResponseState(helperResponse: response));
    });

  }
}
