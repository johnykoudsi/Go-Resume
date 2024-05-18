import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/data/data_sources/skill_actions_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/data/repositories/skill_actions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/domain/use_cases/get_skill_usecase.dart';

part 'get_skills_event.dart';
part 'get_skills_state.dart';

class GetSkillsBloc extends Bloc<GetSkillsEvent, GetSkillsState> {
  GetSkillsBloc() : super(GetSkillsLoadingState()) {
    final SkillActionsRepoImpl skillActionsRepoImpl =
    SkillActionsRepoImpl(SkillActionsDataSource(NetworkHelpers()));
    GetSkillUsecase getSkillUsecase = GetSkillUsecase(skillActionsRepoImpl);


    on<GetAllSkillsEvent>((event, emit) async {
      emit(GetSkillsLoadingState());

      final response = await getSkillUsecase.call(event);

      if(response is List<Skill>){
        emit(GetSkillsLoadedState(skills: response));
      }else{
        emit(GetSkillsErrorState(response: response));
        print(response.response);
      }

    });

  }
}
