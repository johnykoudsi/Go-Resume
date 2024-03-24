import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/all_jobs/presentation/widgtes/job_widget.dart';

class TopJobsSectionWidget extends StatelessWidget {
  const TopJobsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Top Offers",
                  style: AppFontStyles.mediumH3.copyWith(fontSize: 22),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
                      style: AppFontStyles.mediumH5
                          .copyWith(color: AppColors.kMainColor100),
                    ))
              ]),
          const JobWidget(),

        ],
      ),
    );
  }
}
