import 'package:flutter/material.dart';
import 'package:smart_recruitment_flutter_user/features/auth/login/presentation/pages/login_screen.dart';
import 'package:smart_recruitment_flutter_user/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_recruitment_flutter_user/features/job_details/presentation/pages/job_details_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_education_and_certificates/presentation/pages/my_education_and_certificates_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_experineces/presentation/pages/my_experiences_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_notifications/presentation/pages/my_notifications_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_skills/presentation/pages/my_skills_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_submissions/presentation/pages/my_submissions_screen.dart';
import 'package:smart_recruitment_flutter_user/features/auth/login/presentation/pages/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case AppRoutes.splashScreen:
          return const SplashScreen();
        case AppRoutes.login:
          return const LoginScreen();
        case AppRoutes.bottomNavBarScreen:
          return const BottomNavBar();
        case AppRoutes.mySkills:
          return const MySkillsScreen();
        case AppRoutes.myExperiences:
          return const MyExperiencesScreen();
        case AppRoutes.myEducationAndCertificates:
          return const MyEducationAndCertificatesScreen();
        case AppRoutes.mySubmissions:
          return const MySubmissionsScreen();
        case AppRoutes.myNotifications:
          return const MyNotification();
        case AppRoutes.jobDetails:
          return const JobDetailsScreen();

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
