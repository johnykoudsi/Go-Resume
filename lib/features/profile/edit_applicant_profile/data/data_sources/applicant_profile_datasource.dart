import 'dart:convert';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';

class ApplicantProfileDataSource {
  ApplicantProfileDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future editApplicantProfileDataSource(UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    if(updateApplicantProfileEvent.profileImage == null){
      HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
        useUserToken: true,
        url: EndPoints.updateApplicantProfile,
        body: json.encode(updateApplicantProfileEvent.toMapBody()),
      );
      return helperResponse;
    }else{
      print("jjjjjj");
      print(updateApplicantProfileEvent.profileImage.toString());
      HelperResponse helperResponse = await NetworkHelpers.postDataWithFile(
        url: EndPoints.updateApplicantProfile,
        useUserToken: true,
        body: updateApplicantProfileEvent.toMapBody(),
        files: updateApplicantProfileEvent.profileImage!,
        keyName: 'profile_image'
      );
      print(helperResponse);
      return helperResponse;
    }


  }
}
