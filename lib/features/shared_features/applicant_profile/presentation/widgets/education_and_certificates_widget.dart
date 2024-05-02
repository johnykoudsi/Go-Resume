import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class EducationAndCertificatesWidget extends StatelessWidget {
  final String specialization;
  final String startDate;
  final String endDate;
  final String organization;
  final String description;


  const EducationAndCertificatesWidget({
    Key? key,
    required this.specialization,
    required this.startDate,
    required this.endDate,
    required this.organization,
    required this.description,
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
              specialization,
              style: AppFontStyles.boldH6,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$startDate - $endDate",
              style: AppFontStyles.mediumH6,
            ),
            Text(
              organization,
              style: AppFontStyles.mediumH6,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Text(
          description,
          style: AppFontStyles.mediumH7.copyWith(color: AppColors.kGreyColor),
        ),
      ],
    );
  }
}
