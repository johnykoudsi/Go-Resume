import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class ExperienceWidget extends StatelessWidget {

  final Experience experience;
  const ExperienceWidget({
    Key? key,
    required this.experience
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              experience.title,
              style: AppFontStyles.boldH6,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${DateFormat.yM().format(experience.startDate)} - ${DateFormat.yM().format(experience.endDate)}",
              style: AppFontStyles.mediumH6,
            ),
            Text(
              experience.company,
              style: AppFontStyles.mediumH6,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Text(
          experience.description,
          style: AppFontStyles.mediumH7.copyWith(color: AppColors.kGreyColor),
        ),
      ],
    );
  }
}
