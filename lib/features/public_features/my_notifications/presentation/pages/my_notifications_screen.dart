import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/presentation/widgets/notifications_list.dart';

import '../widgets/notification_widget.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notifications",
          style: AppFontStyles.boldH4,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: NotificationsList(),
      // body: ListView.builder(
      //   itemCount: notifications.length,
      //   itemBuilder: (BuildContext context, int index) {
      //    return
      //      NotificationWidget(
      //        imagePath: notifications[index].imagePath,
      //        notificationTitle: notifications[index].notificationTitle,
      //        notificationDetails: notifications[index].notificationDetails,
      //        notificationDate: notifications[index].notificationDate,
      //      );
      //   },
      // ),
    );
  }
}
