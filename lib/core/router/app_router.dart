import 'package:flutter/material.dart';
import 'package:smart_recruitment_flutter_user/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_recruitment_flutter_user/features/my_experineces/presentation/pages/my_experiences_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_skills/presentation/pages/my_skills_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/pages/my_profile_screen.dart';
import '../../features/more/presentation/pages/more_screen.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {

        case AppRoutes.bottomNavBarScreen:
          return const BottomNavBar();
        case AppRoutes.mySkills:
          return const MySkillsScreen();
        case AppRoutes.myExperiences:
          return const MyExperiencesScreen();

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
