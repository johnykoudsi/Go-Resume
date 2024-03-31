import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../../generated/assets.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.08,
                decoration:
                    const BoxDecoration(gradient: AppColors.kLinearColor),
              ),
              Positioned(
                bottom: screenHeight * 0.02,
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "55 Views",
                      style:
                          AppFontStyles.mediumH6.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.65),
                    SvgPicture.asset(
                      Assets.svgEdit,
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Stack(
            children: [
              Container(
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white, width: screenWidth * 0.005),
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/jpg/profile_image.jpg'), // Replace with your profile image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 0,
                child: Container(
                  width: screenWidth * 0.09,
                  height: screenWidth * 0.09,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.svgCamera,
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
