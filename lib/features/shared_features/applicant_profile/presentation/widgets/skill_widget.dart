import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class SkillWidget extends StatelessWidget {
  final String skillName;
  final String description;
  final String imagePath;

  const SkillWidget({
    Key? key,
    required this.skillName,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SvgPicture.asset(
          imagePath,
          width: screenWidth * 0.07,
          height: screenWidth * 0.07,
          color: Colors.black,
        ),
        SizedBox(width: screenWidth*0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skillName,
              style: AppFontStyles.boldH6,
            ),
            Text(
              description,
              style: AppFontStyles.mediumH6,
            ),
          ],
        ),
      ],
    );
  }
}
