import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/pages/favorite_companies_screen.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/pages/all_jobs.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/pages/applicant_profile_screen.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/more/presentation/pages/more_screen.dart';
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
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoggedState) {
              if (state.isRefreshing) {
                return const Center(child: CircularProgressIndicator());
              }
            }
            if (state is UserLoggedState) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ToggleCompanyBloc(),

                  ),
                  BlocProvider(
                    create: (context) => ApplicantProfileBloc(),
                  ),
                ],
                child:  ApplicantProfileScreen(
                  user: state.user.data,
                  visitor: false,
                ),
              );
            }
            return const SizedBox();
          },
        );
      }
      if (screenIndex == 3) {
        return const FavoriteCompaniesScreen();
      }
      if (screenIndex == 4) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoggedState) {
              if (state.isRefreshing) {
                return const Center(child: CircularProgressIndicator());
              }
            }
            if (state is UserLoggedState) {
              return MoreScreen(
                user: state.user.data,
              );
            }
            return const SizedBox();
          },
        );
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
