import 'dart:convert';

import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../presentation/bloc/education_actions_bloc.dart';


class EducationActionsDataSource {
  EducationActionsDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addEducationDataSource(AddEducationEvent addEducationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addEducation,
      body: json.encode(addEducationEvent.toJson()),
    );
    return helperResponse;
  }
  Future deleteEducationDataSource(DeleteEducationEvent deleteEducationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deleteEducation(id: deleteEducationEvent.id),
    );
    print("kkkk"+helperResponse.response);
    return helperResponse;
  }
}
