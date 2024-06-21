import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';

class ExperienceActionsDataSource {
  ExperienceActionsDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addExperienceDataSource(AddExperienceEvent addExperienceEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addExperience,
      body: json.encode(addExperienceEvent.toJson()),
    );
    return helperResponse;
  }

  Future deleteExperienceDataSource(
      DeleteExperienceEvent deleteExperienceEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deleteExperience(id: deleteExperienceEvent.id),
    );
    return helperResponse;
  }

  Future generateExperienceDataSource(
      PostExperienceGenerationEvent postExperienceGeneration) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      mainUrl: EndPoints.aiMainUrl,
      url: EndPoints.generateWorkExperience,
      body: json.encode(postExperienceGeneration.toJson()),
    );

    try {
      Map responseDummy = {
        "work-experience":
        "Software Engineer | Mobile Developer (90soft)\n\n- Develop and maintain mobile applications using Agile methodologies.\n- Collaborate effectively with cross-functional teams, including Scrum teams, to solve complex mobile development challenges.\n- Demonstrate strong problem-solving skills and ability to think creatively.\n- Effectively communicate with both technical and non-technical stakeholders.\n- Manage and maintain a clean codebase using best practices.\n- Stay up-to-date on the latest software development technologies and trends."
      };
      return responseDummy["work-experience"];
    } catch (e) {
      return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError);
    }
  }
}
