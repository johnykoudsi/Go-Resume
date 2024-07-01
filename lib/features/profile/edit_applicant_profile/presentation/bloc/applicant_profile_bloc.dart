import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_recruitment_core/features/auth/data/data_sources/user_datasource.dart';
import 'package:smart_recruitment_core/features/auth/data/repositories/user_repo_impl.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/data/data_sources/applicant_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/data/repositories/applicant_profile_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/domain/use_cases/edit_profile_usecase.dart';

import '../../../../../utility/constant_logic_validation.dart';

part 'applicant_profile_event.dart';
part 'applicant_profile_state.dart';

class ApplicantProfileBloc
    extends Bloc<ApplicantProfileEvent, ApplicantProfileState> {
  static final ApplicantProfileRepoImpl applicantProfileRepoImpl =
      ApplicantProfileRepoImpl(ApplicantProfileDataSource(NetworkHelpers()));
  static final UserRepoImpl userRepoImpl =
      UserRepoImpl(UserDataSource(NetworkHelpers()));
  EditApplicantProfileUsecase applicantProfileUsecase =
      EditApplicantProfileUsecase(applicantProfileRepoImpl);

  ApplicantProfileBloc() : super(ApplicantProfileInit()) {
    on<UpdateApplicantProfileEvent>((event, emit) async {
      add(AddFcmToken());
      emit(ApplicantProfileLoading());
      final response = await applicantProfileUsecase.call(event);
      emit(ApplicantProfileResponseState(helperResponse: response));
    });
    on<AddFcmToken>((event, emit) {
      FirebaseMessaging.instance.getToken().then((fcm) async {
        print('$fcm');
        //add fcm to user
          NetworkHelpers.postDataHelper(
            url: EndPoints.updateApplicantProfile,
            body: json.encode({
              "fcm_token": fcm,
            }),
            useUserToken: true,
          );

      });
    });



  }
}
