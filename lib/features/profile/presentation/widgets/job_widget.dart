import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class JobWidget extends StatelessWidget {
  final String role;
  final String startDate;
  final String endDate;
  final String company;
  final String description;


  const JobWidget({
    Key? key,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.company,
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
              role,
              style: AppFontStyles.boldH5,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$startDate - $endDate",
              style: AppFontStyles.mediumH5,
            ),
            Text(
              company,
              style: AppFontStyles.mediumH5,
            ),
          ],
        ),
        SizedBox(height: screenHeight*0.01),
        Text(
          description,
          style: AppFontStyles.mediumH6.copyWith(color: AppColors.kGreyColor),
        ),
      ],
    );
  }
}
