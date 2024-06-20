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
        int total = json.decode(helperResponse.response)["total"];
        if (total == 0) {
          return 0;
        }

        final data = welcomeNotificationsFromJson(helperResponse.response);

        return data.data;
      } catch (e) {
        return helperResponse.copyWith(
            servicesResponse: ServicesResponseStatues.modelError);
      }
    }
    return helperResponse;
  }
}
