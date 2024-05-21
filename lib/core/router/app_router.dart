import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/education.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/policy.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/auth/presentation/pages/login_screen.dart';
import 'package:smart_recruitment_flutter_user/features/auth/presentation/pages/signup-screen.dart';
import 'package:smart_recruitment_flutter_user/features/auth/presentation/pages/splash_screen.dart';
import 'package:smart_recruitment_flutter_user/features/auth/presentation/pages/verification_screen.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/pages/all_applicants_screen.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/pages/job_details_screen.dart';
import 'package:smart_recruitment_flutter_user/features/my_submissions/presentation/bloc/my_submissions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/my_submissions/presentation/pages/my_submissions_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/pages/applicant_profile_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/pages/all_companies.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/pages/company_profile_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/pages/my_policies_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/pages/edit_profile_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/education_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/pages/add_education_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/pages/my_education_and_certificates_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/pages/add_experience_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/pages/my_experiences_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/pages/my_skills_screen.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/applicant_bottom_nav_bar/bottom_nav_bar.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/company_bottom_nav_bar/recruiter_bottom_nav_bar.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/my_notifications/presentation/pages/my_notifications_screen.dart';
import '../../features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';
import '../../features/profile/company_profile/presentation/pages/add_policy_screen.dart';
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
          SignUpEvent args = settings.arguments as SignUpEvent;
          return CodeVerificationScreenPage(signUpEvent: args);
        case AppRoutes.bottomNavBarScreen:
          return const BottomNavBar();
        case AppRoutes.recruiterBottomNavBar:
          return const RecruiterBottomNavBar();
        case AppRoutes.mySkills:
          List<Skill> args = settings.arguments as List<Skill>;
          return MySkillsScreen(
            skills: args,
          );
        case AppRoutes.myExperiences:
          List<Experience> args = settings.arguments as List<Experience>;
          return BlocProvider(
            create: (context) => ExperienceActionsBloc(),
            child: MyExperiencesScreen(
              experiences: args,
            ),
          );
        case AppRoutes.myEducationAndCertificates:
          List<Education> args = settings.arguments as List<Education>;
          return BlocProvider(
            create: (context) => EducationActionsBloc(),
            child: MyEducationAndCertificatesScreen(
              educations: args,
            ),
          );
        case AppRoutes.mySubmissions:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => MySubmissionsBloc()
                  ..add(ChangeToLoadingApiMySubmissionsEvent()),
              ),
            ],
            child: const MySubmissionsScreen(),
          );
        case AppRoutes.myNotifications:
          return const MyNotification();
        case AppRoutes.jobDetails:
          JobEntity args = settings.arguments as JobEntity;
          return JobDetailsScreen(
            jobEntity: args,
          );
        case AppRoutes.allApplicants:
          return const AllApplicantsScreen();
        // case AppRoutes.applicantProfile:
        //   User user = settings.arguments as User;
        //   return ApplicantProfileScreen(
        //     user: user,
        //   );
        case AppRoutes.viewApplicantProfile:
          User user = settings.arguments as User;
          return ApplicantProfileScreen(
            user: user,
            visitor: true,
          );
        case AppRoutes.companyProfile:
          User user = settings.arguments as User;
          return CompanyProfileScreen(
            user: user,
            visitor: true,
          );
        case AppRoutes.editApplicantProfile:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ApplicantProfileBloc(),
              ),
            ],
            child: const EditApplicantProfileScreen(),
          );
        case AppRoutes.addExperience:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ExperienceActionsBloc(),
              ),
            ],
            child: const AddExperienceScreen(),
          );
        case AppRoutes.addEducation:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EducationActionsBloc(),
              ),
            ],
            child: const AddEducationScreen(),
          );
        // case AppRoutes.benefitsScreen:
        //   List<BenefitEntity> args = settings.arguments as  List<BenefitEntity>;
        //   return BlocProvider(
        //     create: (context) => BenefitsBloc(),
        //     child: BenefitsScreen(
        //       benefits: args,
        //     ),
        //   );
        case AppRoutes.myPolicies:
          List<Policy>? args = settings.arguments as List<Policy>?;
          return BlocProvider(
            create: (context) => PoliciesActionsBloc(),
            child: MyPoliciesScreen(
              policies: args,
            ),
          );
        case AppRoutes.addPolicy:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PoliciesActionsBloc(),
              ),
            ],
            child: const AddPolicyScreen(),
          );
        case AppRoutes.allCompanyScreen:
          return const AllCompaniesScreen();
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
