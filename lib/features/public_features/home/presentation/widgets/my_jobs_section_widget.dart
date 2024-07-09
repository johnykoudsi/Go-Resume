import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';

import '../../../../../utility/app_strings.dart';

class MyJobsSectionWidget extends StatelessWidget {
  const MyJobsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
             Text(
              AppStrings.myJobs,
              style: AppFontStyles.mediumH4,
            ),
            TextButton(
                onPressed: () {
                  final userState = context.read<UserBloc>().state;
                  if (userState is! UserLoggedState) {
                    return;
                  }
                  Navigator.pushNamed(context, AppRoutes.myJobs,
                      arguments: userState.user.data);
                },
                child: Text(
                  AppStrings.seeAll,
                  style: AppFontStyles.mediumH4
                      .copyWith(color: AppColors.kMainColor100),
                ))
          ]),
          //   const JobWidget(),
        ],
      ),
    );
  }
}
