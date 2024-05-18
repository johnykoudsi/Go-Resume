import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/pages/pinned_applicants_screen.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/work_fields/work_fields_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/pages/add_job_screen.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/pages/my_jobs_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/pages/company_profile_screen.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/more/presentation/pages/more_screen.dart';


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
        return const PinnedApplicantsScreen();
      }
      if (screenIndex == 2) {
        return MultiBlocProvider(

          providers: [
            BlocProvider(
              create: (context) => AddJobBloc(),
            ),
            BlocProvider(
              create: (context) => BenefitsBloc(),
            ),
            BlocProvider(
              create: (context) => WorkFieldsBloc(),
            ),
          ],
          child: const AddJobScreen(),
        );
      }
      if (screenIndex == 3) {
        return const CompanyProfileScreen();
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
