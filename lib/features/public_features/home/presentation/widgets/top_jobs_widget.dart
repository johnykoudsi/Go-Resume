import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class TopJobsSectionWidget extends StatelessWidget {
  const TopJobsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Top Offers",
                  style: AppFontStyles.mediumH4,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
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
