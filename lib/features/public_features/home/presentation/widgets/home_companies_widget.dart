import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';

class HomeCompaniesSectionWidget extends StatelessWidget {
  const HomeCompaniesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Top Companies",
              style: AppFontStyles.mediumH4,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.allCompanyScreen);
                },
                child: Text(
                  "See More",
                  style: AppFontStyles.mediumH4
                      .copyWith(color: AppColors.kMainColor100),
                ))
          ]),
        ),
      ],
    );
  }
}
