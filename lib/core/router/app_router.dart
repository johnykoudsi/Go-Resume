import 'package:flutter/material.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/all_applicants/presentation/pages/all_applicants_screen.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/bottom_nav_bar/recruiter_bottom_nav_bar.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/company_profile/presentation/pages/company_profile_screen.dart';
import '../../features/applicant_features/bottom_nav_bar/bottom_nav_bar.dart';
import '../../features/applicant_features/my_education_and_certificates/presentation/pages/my_education_and_certificates_screen.dart';
import '../../features/applicant_features/my_experineces/presentation/pages/my_experiences_screen.dart';
import '../../features/applicant_features/my_skills/presentation/pages/my_skills_screen.dart';
import '../../features/applicant_features/my_submissions/presentation/pages/my_submissions_screen.dart';
import '../../features/shared_features/applicant_profile/presentation/pages/applicant_profile_screen.dart';
import '../../features/shared_features/auth/presentation/pages/login_screen.dart';
import '../../features/shared_features/auth/presentation/pages/signup-screen.dart';
import '../../features/shared_features/auth/presentation/pages/splash_screen.dart';
import '../../features/shared_features/auth/presentation/pages/verification_screen.dart';
import '../../features/shared_features/job_details/presentation/pages/job_details_screen.dart';
import '../../features/shared_features/my_notifications/presentation/pages/my_notifications_screen.dart';
import 'app_routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case AppRoutes.splashScreen:
          return const SplashScreen();
        case AppRoutes.login:
          return const LoginScreen();
        case AppRoutes.signup:
          return const SignupScreen();
        case AppRoutes.verificationCode:
          return const VerificationScreen();
        case AppRoutes.bottomNavBarScreen:
          return const BottomNavBar();
        case AppRoutes.recruiterBottomNavBar:
          return const RecruiterBottomNavBar();
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
        case AppRoutes.allApplicants:
          return const AllApplicantsScreen();
        case AppRoutes.applicantProfile:
          return const ApplicantProfileScreen();
        case AppRoutes.companyProfile:
          return const CompanyProfileScreen();


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
