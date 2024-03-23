import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/all_jobs/presentation/pages/all_jobs.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/pages/my_profile.dart';

class GetSelectedScreenByIndex extends StatelessWidget {
  const GetSelectedScreenByIndex({required this.screenIndex, Key? key})
      : super(key: key);
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (screenIndex == 1) {
        return const AllJobsScreen();
      }
      if (screenIndex == 2) {
        return const MyProfile();
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
