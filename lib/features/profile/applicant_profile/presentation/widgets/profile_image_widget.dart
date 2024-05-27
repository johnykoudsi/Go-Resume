import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';

import '../../../../../generated/assets.dart';

class ProfileImageWidget extends StatefulWidget {
  final bool visitor;
  final String profileImage;
  final String viewsNumber;
  final bool isCompany;
  const ProfileImageWidget({
    Key? key,
    required this.profileImage,
    required this.viewsNumber,
    this.visitor = false,
    required this.isCompany,
  }) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          bottom: 1,
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
                      "${widget.viewsNumber} Views",
                      style:
                          AppFontStyles.mediumH6.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.65),
                    GestureDetector(
                      onTap: () {
                        if (widget.isCompany) {
                          if (widget.visitor) {
                            //todo add fav toggle
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.editCompanyProfile);
                          }
                        } else {
                          if (widget.visitor) {
                            //todo add pin toggle
                          } else {}
                          Navigator.pushNamed(
                              context, AppRoutes.editApplicantProfile);
                        }
                      },
                      child: SvgPicture.asset(
                        //visitor and it's applicant
                        widget.visitor && !widget.isCompany == true
                            ? Assets.svgPin
                            :
                            //visitor and it's company
                            widget.visitor && widget.isCompany == true
                                ? Assets.svgStar
                                :
                                //else
                                Assets.svgEdit,
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Stack(
            children: [
              CircularProfileImage(
                borderColor: Colors.white,
                image: widget.profileImage,
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
              ),
              !widget.visitor
                  ? Positioned(
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
                    )
                  : const Text(""),
            ],
          ),
        ),
      ],
    );
  }
}
