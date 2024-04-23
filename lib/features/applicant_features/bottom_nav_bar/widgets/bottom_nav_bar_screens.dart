import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import '../../../shared_features/applicant_profile/presentation/pages/applicant_profile_screen.dart';
import '../../../shared_features/more/presentation/pages/more_screen.dart';
import '../../all_companies/presentation/pages/all_companies.dart';
import '../../all_jobs/presentation/pages/all_jobs.dart';
import '../../home/presentation/pages/home_screen.dart';

class GetSelectedScreenByIndex extends StatelessWidget {
  const GetSelectedScreenByIndex({required this.screenIndex, Key? key})
      : super(key: key);
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (screenIndex == 0) {
        return const HomeScreen();
      }
      if (screenIndex == 1) {
        return const AllJobsScreen();
      }
      if (screenIndex == 2) {
        return const ApplicantProfileScreen();
      }
      if (screenIndex == 3) {
        return const AllCompaniesScreen();
      }
      if (screenIndex == 4) {
        return const MoreScreen();
      }
      return const Scaffold(
        body: Center(
          child: Text(
            'Check Named Route',
            style: AppFontStyles.mediumH1,
          ),
        ),
      );
    });
  }
}
