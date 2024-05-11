import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';


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
  Future deleteExperienceDataSource(DeleteExperienceEvent deleteExperienceEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deleteExperience(id: deleteExperienceEvent.id),
    );
    return helperResponse;
  }
}
