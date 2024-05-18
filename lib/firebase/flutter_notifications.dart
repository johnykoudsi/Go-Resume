// import 'dart:async';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:smart_recruitment_core/utility/theme/color_style.dart';
//
// class FlutterNotificationsClass {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static BuildContext? context;
//
//   // @pragma('vm:entry-point')
//   // void notificationTapBackground(NotificationResponse notificationResponse) {
//   //
//   //   // todo: push to notification screen
//   //   // Navigator.pushNamed(context!, notificationScreen,
//   //   //     arguments: ServiceType.store);
//   // }
//
//   static AndroidNotificationChannel channel = const AndroidNotificationChannel(
//     'nostra_casa',
//     'nostra_casa', // title// description
//     importance: Importance.max,
//     enableLights: true,
//     ledColor: AppColors.fontColor,
//   );
//
//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print('Handling a background message ${message.messageId}');
//     flutterLocalNotificationsPlugin.show(
//         message.data.hashCode,
//         message.data['title'],
//         message.data['body'],
//         NotificationDetails(
//           android: AndroidNotificationDetails(channel.id, channel.name,
//               enableVibration: true
//           ),
//         ));
//   }
//
//   Future initLocalNotificationChannel() async {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
//   void localNotificationsRequestPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
//   }
//
//   Future<void> handleForeGroundNotification() async {
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('@drawable/app_icon');
//     var initializationSettingsIos = const DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );
//
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIos,
//     );
//
//     // flutterLocalNotificationsPlugin.initialize(
//     //   initializationSettings,
//     //   onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     //   onDidReceiveNotificationResponse: (details) {
//     //     // todo: push to notification screen
//     //
//     //     // Navigator.pushNamed(context!, notificationScreen,
//     //     //     arguments: ServiceType.store);
//     //   },
//     // );
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('message ${message.data}');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       var responseData = message.data;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 enableLights: channel.enableLights,
//                 ledColor: channel.ledColor,
//                 ledOnMs: 100,
//                 ledOffMs: 3000,
//                 enableVibration: true,
//                 icon: android.smallIcon,
//                 color: const Color(0xFF145770),
//               ),
//             ));
//       }
//     });
//   }
// }
