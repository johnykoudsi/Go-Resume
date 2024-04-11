import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/more/presentation/pages/more_screen.dart';

import '../../../applicant_features/all_companies/presentation/pages/all_companies.dart';
import '../../../applicant_features/all_jobs/presentation/pages/all_jobs.dart';
import '../../../applicant_features/profile/presentation/pages/my_profile_screen.dart';
import '../../home/presentation/pages/my_jobs_screen.dart';


class GetSelectedRecruiterScreenByIndex extends StatelessWidget {
  const GetSelectedRecruiterScreenByIndex({required this.screenIndex, Key? key})
      : super(key: key);
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (screenIndex == 0) {
        return const MyJobsScreen();
      }
      if (screenIndex == 1) {
        return const AllJobsScreen();
      }
      if (screenIndex == 2) {
        return const MyProfile();
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
