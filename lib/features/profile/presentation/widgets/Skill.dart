import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class Skill extends StatelessWidget {
  final String skillName;
  final String description;
  final String imagePath;

  const Skill({
    Key? key,
    required this.skillName,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        SvgPicture.asset(
          imagePath,
          width: screenWidth * 0.07,
          height: screenWidth * 0.07,
          color: Colors.black,
        ),
        SizedBox(width: screenWidth*0.05), // Add spacing between the image and the text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skillName,
              style: AppFontStyles.boldH5,
            ),
            Text(
              description,
              style: AppFontStyles.mediumH5,
            ),
          ],
        ),
      ],
    );
  }
}
