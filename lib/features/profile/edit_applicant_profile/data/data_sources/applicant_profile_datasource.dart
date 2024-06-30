import 'dart:convert';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/bio_generation/bio_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/toggle_applicant/toggle_applicant_bloc.dart';

class ApplicantProfileDataSource {
  ApplicantProfileDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future editApplicantProfileDataSource(
      UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    if (updateApplicantProfileEvent.profileImage != null) {
      HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
          url: EndPoints.updateApplicantProfile,
          useUserToken: true,
          body: updateApplicantProfileEvent.toMapBody(),
          files: updateApplicantProfileEvent.profileImage!,
          keyName: 'profile_image');
      return helperResponse;
    } else if (updateApplicantProfileEvent.coverImage != null) {
      HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
          url: EndPoints.updateApplicantProfile,
          useUserToken: true,
          body: updateApplicantProfileEvent.toMapBody(),
          files: updateApplicantProfileEvent.coverImage!,
          keyName: 'cover_image');
      return helperResponse;
    } else {
      HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
        useUserToken: true,
        url: EndPoints.updateApplicantProfile,
        body: json.encode(updateApplicantProfileEvent.toMapBody()),
      );
      return helperResponse;
    }
  }
  Future toggleApplicant(ToggleApplicantApiEvent toggleApplicantApiEvent) async {

    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.pinApplicantToggle(id: toggleApplicantApiEvent.id),
    );
    print(helperResponse.response.toString());
    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isPinned = json.decode(helperResponse.response)["data"]["is_pinned"];
        return isPinned;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
  Future getApplicantStatus({
    required GetApplicantStatusEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.isApplicantPinned(id: event.id),
      useUserToken: true,
    );

    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final isPinned = json.decode(helperResponse.response)["data"]["is_pinned"];
        return isPinned;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

  Future generateBio(PostBioGenerationEvent postBioGenerationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      mainUrl: EndPoints.aiMainUrl,
      url: EndPoints.aiAboutMe,
      body: json.encode(postBioGenerationEvent.toJson()),
    );

    try {
      Map responseDummy = {
        "about_me": "## About Me\n\nHighly motivated Software Engineer with a strong background in agile methodologies and software development best practices. I am proficient in problem-solving, collaboration, communication, and data management. I am passionate about clean architecture, database optimization, and fast-paced learning. I am eager to join a team where I can utilize my skills and contribute to the creation of exceptional software solutions."
      };
      return responseDummy["about_me"];
    } catch (e) {
      return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError);
    }
  }
}
