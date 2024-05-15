import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';

class SkillActionsDataSource {
  SkillActionsDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addSkillDataSource(AddSkillEvent addSkillEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
      useUserToken: true,
      url: EndPoints.updateApplicantProfile,
      body: addSkillEvent.toJson(),
    );
    print(helperResponse.response);
    return helperResponse;
  }

  Future getSkillsDataSource(GetAllSkillsEvent getSkillEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      useUserToken: true,
      url: EndPoints.getSkills,
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];

        return List<Skill>.from(
          data.map((x) => Skill.fromJson(x)),
        );

      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
