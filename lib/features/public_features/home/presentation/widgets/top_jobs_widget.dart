import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';

import '../../../../../utility/app_strings.dart';

class TopJobsSectionWidget extends StatelessWidget {
  const TopJobsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
             Text(
              "topOffers".tr(),
              style: AppFontStyles.mediumH4,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.allJobs);
                },
                child: Text(
                  "seeAll".tr(),
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
