import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/auth/presentation/pages/my_profile.dart';
import '../../features/bottom_nav_bar/bottom_nav_bar.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {

        case AppRoutes.myProfileScreen:
          return const MyProfile();

        case AppRoutes.bottomNavBarScreen:
          return const BottomNavBar();

        default:
          return const Scaffold(
            body: Center(
              child: Text(
                'Check Named Route',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          );
      }
    });
  }
}
