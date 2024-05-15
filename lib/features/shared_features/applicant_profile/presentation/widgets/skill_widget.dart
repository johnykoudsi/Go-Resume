import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

class SkillWidget extends StatelessWidget {
  final Skill skill;
  final bool showDelete;
  final Function(Skill)? onDeletePressed;
  const SkillWidget({
    Key? key,
    required this.skill,
    this.showDelete = false,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svgCase,
              width: screenWidth * 0.07,
              height: screenWidth * 0.07,
              color: Colors.black,
            ),
            SizedBox(width: screenWidth * 0.05),
            Text(
              skill.name,
              style: AppFontStyles.boldH6,
            ),
          ],
        ),
        if(showDelete)
        IconButton(onPressed: (){
          if(onDeletePressed != null){
            onDeletePressed!(skill);
          }
        }, icon: const Icon(Icons.delete_rounded,color: AppColors.kSecondColor,))
      ],
    );
  }
}
