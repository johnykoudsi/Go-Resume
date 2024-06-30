

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../firebase/notification.dart';
import '../widgets/splash_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
  }
   void printFcmToken()async{
    final NotificationSetUp _noti = NotificationSetUp();
    final String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token");
    print(token.toString());
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedState) {
          printFcmToken();
          Navigator.of(context).pushNamedAndRemoveUntil(
              state.user.data.company==null?
              AppRoutes.bottomNavBarScreen:AppRoutes.recruiterBottomNavBar,
                  (Route<dynamic> route) => false);
        }
        if (state is UserNotLoggedState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      },
      child: Scaffold(
        body: SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: const SplashLogoWidget()),
      ),
    );
  }
}
