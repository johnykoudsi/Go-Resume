import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/ads/domain/entities/ad_entity.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/domain/entities/my_notifications_entity.dart';

import '../../presentation/bloc/report_user_bloc.dart';




class ReportUserDataSource {
  ReportUserDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;
  Future reportUser(ReportUserApiEvent reportUserEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.updateCompanyProfile,
      body: json.encode(reportUserEvent.toMapBody()),
    );
    return helperResponse;

  }



}
