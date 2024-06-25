// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
// import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
// import 'package:smart_recruitment_core/utility/theme/color_style.dart';
// import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
// import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/presentation/bloc/my_notifications_bloc.dart';
// import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
//
// import '../../../../../generated/assets.dart';
// import '../../../../../utility/app_strings.dart';
// import '../../../../../utility/global_widgets/shimmer.dart';
//
// import '../../domain/entities/my_notifications_entity.dart';
//
// class NotificationsList extends StatefulWidget {
//   NotificationsList({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationsList> createState() => _NotificationsListState();
// }
//
// class _NotificationsListState extends State<NotificationsList> {
//   ScrollController scrollController = ScrollController();
//   MyNotificationsBloc myNotificationsBloc = MyNotificationsBloc();
//   NotificationsSearchFilter searchFilter = NotificationsSearchFilter();
//
//   @override
//   void initState() {
//     myNotificationsBloc.add(ChangeToLoadingMyNotificationsEvent(searchFilterProperties: searchFilter));
//     scrollController.addListener(() {
//       if (scrollController.position.maxScrollExtent ==
//           scrollController.offset) {
//         myNotificationsBloc.add(
//           GetMyNotificationsEvent(
//             searchFilterProperties: searchFilter,
//           ),
//         );
//       }
//     });
//     super.initState();
//   }
//
//   void search() {
//     myNotificationsBloc.add(
//       ChangeToLoadingMyNotificationsEvent(
//         searchFilterProperties: searchFilter,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return BlocProvider.value(
//       value: myNotificationsBloc,
//
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(AppStrings.myJobs),
//           centerTitle: false,
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//           search();
//           },
//           child: BlocBuilder<MyNotificationsBloc, MyNotificationsState>(
//             builder: (context, state) {
//               if (state is MyNotificationsLoadedState && state.notifications.isNotEmpty) {
//                 return ListView.builder(
//                     padding: const EdgeInsets.all(18),
//                     controller: scrollController,
//                     itemCount: state.hasReachedMax
//                         ? state.notifications.length
//                         : state.notifications.length + 2,
//                     itemBuilder: (BuildContext context, int index) {
//                       if (index >= state.notifications.length) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: SizedBox(
//                             height: 130,
//                             child: ShimmerLoader(),
//                           ),
//                         );
//                       }
//                       return NotificationItemWidget(
//                          notification: state.notifications[index], index: index,
//                       );
//                     });
//               }
//               if (state is MyNotificationsLoadedState) {
//                 return const NoDataWidget();
//               }
//               if (state is MyNotificationsLoadingState) {
//                 return ListView.builder(
//                     padding: const EdgeInsets.all(18),
//                     controller: scrollController,
//                     itemCount: 8,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: SizedBox(height: 130, child: ShimmerLoader()),
//                       );
//                     });
//               }
//               return SomethingWrongWidget(
//                 svgPath: Assets.svgNoInternet,
//                 elevatedButtonWidget: ElevatedButtonWidget(
//                   title: "Refresh",
//                   onPressed: () {
//                     context
//                         .read<MyNotificationsBloc>()
//                         .add(ChangeToLoadingMyNotificationsEvent());
//
//                     //search(userS);
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//           }
//
//
//
//   }
//
//
// class NotificationItemWidget extends StatelessWidget {
//   NotificationItemWidget(
//       {required this.notification, Key? key, required this.index})
//       : super(key: key);
//   NotificationEntity notification;
//   int index;
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Column(
//       children: [
//         Container(
//           decoration: const BoxDecoration(
//             color:
//           AppColors.kBackGroundColor
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(
//                 left: screenWidth * 0.038,
//                 right: screenWidth * 0.038,
//                 top: screenHeight * 0.02,
//                 bottom: screenHeight * 0.02),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     border: Border.all(color: Colors.black),
//                   ),
//                   child: const CircleAvatar(
//                     radius: 37,
//                     backgroundColor: Colors.black,
//                     child: CircleAvatar(
//                       radius: 35,
//                       foregroundImage: AssetImage(Assets.pngJobSearch),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: screenWidth * 0.02,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         notification.title,
//                         style: AppFontStyles.boldH3,
//                       ),
//                       Text(
//                         notification.body??"",
//                         style: Theme.of(context).textTheme.headline5,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: screenWidth*0.9,
//           height: screenWidth * 0.005, // Adjust height as needed
//           decoration: BoxDecoration(
//             color: Colors.grey, // Divider color
//             borderRadius: BorderRadius.circular(
//                 screenWidth * 0.01), // Rounded corners
//           ),
//         ),
//
//       ],
//     );
//   }
// }
