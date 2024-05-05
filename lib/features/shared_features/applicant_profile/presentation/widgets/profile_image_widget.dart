import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';

import '../../../../../generated/assets.dart';


class ProfileImageWidget extends StatelessWidget {
  final bool visitor;
  final String profileImage;
  final String viewsNumber;
   const ProfileImageWidget({Key? key,
  required this.profileImage,
  required this.viewsNumber,
    this.visitor=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          bottom:1,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.06,
                decoration:
                    const BoxDecoration(gradient: AppColors.kLinearColor),
              ),
              Positioned(
                bottom: screenHeight * 0.01,
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$viewsNumber Views",
                      style:
                          AppFontStyles.mediumH6.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.65),
                    !visitor ?
                    GestureDetector(
                      onTap: (){Navigator.pushNamed(context, AppRoutes.editApplicantProfile);},
                      child: SvgPicture.asset(
                        Assets.svgEdit,
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        color: Colors.white,
                      ),
                    ): const Text("")
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Stack(
            children: [
              CircularProfileImage(borderColor: Colors.white, image: profileImage,width: screenWidth * 0.35,height: screenWidth * 0.35,),
              !visitor ?
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
              ): const Text(""),
            ],
          ),
        ),
      ],
    );
  }
}
