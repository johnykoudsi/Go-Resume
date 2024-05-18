import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/app_bloc_observer.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_core/utility/theme/app_style.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/firebase/firebase_notifications.dart';
import 'package:smart_recruitment_flutter_user/firebase_options.dart';
import 'core/router/app_router.dart';
import 'firebase/flutter_notifications.dart';

FlutterNotificationsClass flutterNotifications = FlutterNotificationsClass();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  flutterNotifications.flutterLocalNotificationsPlugin.show(
      message.data.hashCode,
      message.data['title'],
      message.data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          FlutterNotificationsClass.channel.id,
          FlutterNotificationsClass.channel.name,
          enableVibration: true,
        ),
      ));
}
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  const AndroidInitializationSettings('@drawable/app_icon');
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseNotifications().initNotifications();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: AppColors.kSecondColor, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.kBackGroundColor
  ));
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translation',
    startLocale: const Locale('en'),
    fallbackLocale: const Locale('en'),
    child: MyApp(appRouter: AppRouter()),
  ));

}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;

  const MyApp({required this.appRouter, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    NetworkHelpers.globalUserBloc = UserBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NetworkHelpers.globalUserBloc..add(CheckUserFromLocalStorage()),
      child: MaterialApp(
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        theme: AppStyle.theme,
        onGenerateRoute: widget.appRouter.onGenerateRoute,
      ),
    );
  }
}
