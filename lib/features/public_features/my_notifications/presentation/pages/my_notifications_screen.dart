import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/presentation/widgets/notifications_list.dart';

import '../../../../../generated/assets.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/no_data_widget.dart';
import '../../../../../utility/global_widgets/shimmer.dart';
import '../../domain/entities/my_notifications_entity.dart';
import '../bloc/my_notifications_bloc.dart';
import '../widgets/notification_widget.dart';

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();

}

class _MyNotificationState extends State<MyNotification> {
  ScrollController scrollController = ScrollController();
  MyNotificationsBloc myNotificationsBloc = MyNotificationsBloc();
  NotificationsSearchFilter searchFilter = NotificationsSearchFilter();

  @override
  void initState() {
    myNotificationsBloc.add(ChangeToLoadingMyNotificationsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        myNotificationsBloc.add(
          GetMyNotificationsEvent(
            searchFilterProperties: searchFilter,
          ),
        );
      }
    });
    super.initState();
  }

  void search() {
    myNotificationsBloc.add(
      ChangeToLoadingMyNotificationsEvent(
        searchFilterProperties: searchFilter,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: myNotificationsBloc,

      child: Scaffold(
        appBar: AppBar(
          title: Text("myNotifications".tr(),style: AppFontStyles.boldH2,),
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            search();
          },
          child: BlocBuilder<MyNotificationsBloc, MyNotificationsState>(
            builder: (context, state) {
              if (state is MyNotificationsLoadedState && state.notifications.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    controller: scrollController,
                    itemCount: state.hasReachedMax
                        ? state.notifications.length
                        : state.notifications.length + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.notifications.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 130,
                            child: ShimmerLoader(),
                          ),
                        );
                      }
                      return NotificationItemWidget(
                        notification: state.notifications[index], index: index,
                      );
                    });
              }
              if (state is MyNotificationsLoadedState) {
                return const NoDataWidget();
              }
              if (state is MyNotificationsLoadingState) {
                return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    controller: scrollController,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(height: 130, child: ShimmerLoader()),
                      );
                    });
              }
              return SomethingWrongWidget(
                svgPath: Assets.svgNoInternet,
                elevatedButtonWidget: ElevatedButtonWidget(
                  title: "refresh".tr(),
                  onPressed: () {
                    context
                        .read<MyNotificationsBloc>()
                        .add(ChangeToLoadingMyNotificationsEvent());

                    //search(userS);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget(
      {required this.notification, Key? key, required this.index})
      : super(key: key);
  NotificationsModel notification;
  int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color:
              AppColors.kBackGroundColor
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.038,
                right: screenWidth * 0.038,
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child:  CircleAvatar(
                    radius: 37,
                    backgroundColor: AppColors.kBackGroundColor,
                    child: ClipOval(
                      child: FadeInImage(
                        key: UniqueKey(),
                        placeholder: const AssetImage(Assets.pngRandomUser),
                        image: NetworkImage(notification.userImage??""),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.pngRandomUser,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: AppFontStyles.boldH3,
                      ),
                      Text(
                        notification.body??"",
                        style: AppFontStyles.mediumH5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: screenWidth*0.9,
          height: screenWidth * 0.005, // Adjust height as needed
          decoration: BoxDecoration(
            color: Colors.grey, // Divider color
            borderRadius: BorderRadius.circular(
                screenWidth * 0.01), // Rounded corners
          ),
        ),

      ],
    );
  }
}