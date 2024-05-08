import 'dart:convert';

import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../presentation/bloc/applicant_profile_bloc.dart';

class ApplicantProfileDataSource {
  ApplicantProfileDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future editApplicantProfileDataSource(UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.updateApplicantProfile,
      body: json.encode(updateApplicantProfileEvent.toJson()),
      // json.encode({
      //   // "full_name": updateApplicantProfileEvent.fullName,
      //   // "skills":[],
      //   // "gender":updateApplicantProfileEvent.gender,
      //   // "dob": updateApplicantProfileEvent.dob,
      //   // "bio": updateApplicantProfileEvent.bio,
      // }),
    );
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        return userFromJson(helperResponse.response);
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
