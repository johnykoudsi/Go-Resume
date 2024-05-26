import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';


class MoreItemsWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final double topPadding;
  final VoidCallback? onTap;
  const MoreItemsWidget({Key? key,
    required this.iconPath,
    required this.text,
    required this.topPadding,
    this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(top: topPadding,left: screenWidth*0.05,right: screenWidth*0.05),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration:  const BoxDecoration(
                gradient: AppColors.kLinearColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: screenWidth * 0.06,
                  height: screenWidth * 0.06,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: screenWidth*0.05,),
            Text(text,style: AppFontStyles.boldH4)
          ],
        ),
      ),
    );
  }
}
