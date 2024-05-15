import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class SkillWidget extends StatelessWidget {
  final Skill skill;

  const SkillWidget({
    Key? key,
    required this.skill,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SvgPicture.asset(
          skill.icon,
          width: screenWidth * 0.07,
          height: screenWidth * 0.07,
          color: Colors.black,
        ),
        SizedBox(width: screenWidth*0.05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skill.name,
              style: AppFontStyles.boldH6,
            ),
            // Text(
            //   description,
            //   style: AppFontStyles.mediumH6,
            // ),
          ],
        ),
      ],
    );
  }
}
