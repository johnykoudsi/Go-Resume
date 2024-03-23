import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double getWidth = MediaQuery.of(context).size.width;
    double getHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: const Color(0xff232323),
          animationDuration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.k15BorderRadius,
          ),
        ),
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.all(18),
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "#12",
                style: AppFontStyles.mediumH5,
              ),
              const Text(
                "Software Engineer",
                style: AppFontStyles.boldH5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "4,500,000 SYP",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "Remote",
                    style: AppFontStyles.mediumH5,
                  ),
                ],
              ),
              Text(
                "Damascus - Syria - Company",
                style: AppFontStyles.regularH6
                    .copyWith(color: AppColors.kGreyColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    DateFormat.yMd().format(DateTime.now()),
                    style: AppFontStyles.regularH6
                        .copyWith(color: AppColors.kGreyColor),
                  ),
                  Text(
                    "Open",
                    style: AppFontStyles.boldH5.copyWith(color: AppColors.kGreenColor),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
