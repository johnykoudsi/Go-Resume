import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/education.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class EducationAndCertificatesWidget extends StatelessWidget {
  final Education education;

  const EducationAndCertificatesWidget({
    required this.education,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            education.name,
            overflow: TextOverflow.visible,
            style: AppFontStyles.boldH6,
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DateFormat.yM().format(education.startDate)} - ${DateFormat.yM().format(education.endDate)}",
                style: AppFontStyles.mediumH6,
              ),
              Text(
                education.university,
                style: AppFontStyles.mediumH6,
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            education.description,
            style: AppFontStyles.mediumH7.copyWith(color: AppColors.kGreyColor),
          ),
        ],
      ),
    );
  }
}
