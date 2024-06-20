import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/presentation/bloc/my_notifications_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';

import '../../../../../generated/assets.dart';
import '../../../../../utility/global_widgets/shimmer.dart';

import '../../domain/entities/my_notifications_entity.dart';

class NotificationsList extends StatefulWidget {
  NotificationsList({Key? key}) : super(key: key);

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<MyNotificationsBloc>().add(
          GetMyNotificationsEvent(
            searchFilterProperties: NotificationsSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  void search() {

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<MyNotificationsBloc, MyNotificationsState>(
        builder: (context, state) {
          if (state is MyNotificationsLoadedState) {
            print(state.notifications.toString());
            if(state.notifications.isEmpty){
              return const NoDataWidget();
            }
            return RefreshIndicator(
              onRefresh: () async{
                search();
              },
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.hasReachedMax
                      ? state.notifications.length
                      : state.notifications.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.notifications.length) {
                      return Container(
                        decoration: BoxDecoration(
                          color: (index % 2 == 1)
                              ? AppColors.kBackGroundColor
                              : AppColors.kGreyColor,
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
                                  border: Border.all(color: Colors.black,),
                                ),
                                child: const CircleAvatar(
                                  radius: 37,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 35,
                                    foregroundImage: AssetImage(Assets.pngJobSearch),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.7,),
                              SizedBox(height: screenHeight*0.01,),
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.5,),
                              SizedBox(height: screenHeight*0.01,),
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.4,),
                            ],
                          ),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        search();
                      },
                      child: NotificationItemWidget(
                        notification: state.notifications[index],
                        index: index,
                      ),
                    );
                  }),
            );
          }
          if (state is MyNotificationsInitial) {
            return ListView.builder(
                controller: scrollController,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: (index % 2 == 1)
                          ? AppColors.kBackGroundColor
                          : AppColors.kGreyColor,
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
                              border: Border.all(color: Colors.black),
                            ),
                            child: const CircleAvatar(
                              radius: 37,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 35,
                                foregroundImage: AssetImage(Assets.pngJobSearch),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.7,),
                              SizedBox(height: screenHeight*0.01,),
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.5,),
                              SizedBox(height: screenHeight*0.01,),
                              ShimmerLoader(height: screenHeight*0.04,width: screenWidth*0.4,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return SomethingWrongWidget(
            elevatedButtonWidget: ElevatedButtonWidget(
              title: "Refresh".tr(),
              onPressed: () {
                search();
              },
            ),
          );
        });
  }
}

class NotificationItemWidget extends StatelessWidget {
  NotificationItemWidget(
      {required this.notification, Key? key, required this.index})
      : super(key: key);
  NotificationEntity notification;
  int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color:
        (index % 2 == 1) ? AppColors.kBackGroundColor : Colors.grey,
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
                border: Border.all(color: Colors.black),
              ),
              child: const CircleAvatar(
                radius: 37,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 35,
                  foregroundImage: AssetImage(Assets.pngJobSearch),
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
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
