import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/domain/entities/my_notifications_entity.dart';

import '../../../../../utility/constant_logic_validation.dart';
import '../../presentation/bloc/my_notifications_bloc.dart';

class MyNotificationsDataSource {
  MyNotificationsDataSource(this.networkHelpers);
  NetworkHelpers networkHelpers;

  Future getMyNotificationsDataSource({
    required GetMyNotificationsEvent event,
  }) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      url: EndPoints.getMyNotifications(
        page: event.searchFilterProperties.page,
        limit: kGetLimit,
      ),
      useUserToken: true,
    );
    print(helperResponse.servicesResponse);


    if (helperResponse.servicesResponse == ServicesResponseStatues.success) {
      try {
        final data = json.decode(helperResponse.response)["data"];
        return  List<NotificationModel>.from(data.map((x) => NotificationModel.fromJson(x)));
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }

}
