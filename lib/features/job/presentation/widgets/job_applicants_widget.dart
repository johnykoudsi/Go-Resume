import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';
import '../../../../../generated/assets.dart';

class JobApplicantsWidget extends StatelessWidget {
  final bool canReject;
  User user;
  JobApplicantsWidget({Key? key, this.canReject = true,required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: const Color(0xff232323),
          animationDuration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.k15BorderRadius,
          ),
        ),
        onPressed: () {
          // Navigator.push(context ,  MaterialPageRoute(
          //   builder: (context) => const ApplicantProfileScreen(visitor: true), // or false based on your logic
          // ),
          // );
        },
        child: Stack(
          children: [
            canReject
                ? Positioned(
              right: 0,
                  child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.cancel_outlined,color: AppColors.kRedColor,)),
                )
                : const Text(""),
            Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircularProfileImage(borderColor: AppColors.kMainColor100, image: Assets.jpgProfileImage,width: screenWidth*0.13,height: screenWidth*0.13,),
                      SizedBox(width: screenWidth*0.02,),
                      const Text("John Due",style: AppFontStyles.boldH6,),
                      const Spacer(),

                    ],
                  ),
                  SizedBox(height: screenWidth*0.01,),
                  const Text(
                    "Software Engineer",
                    style: AppFontStyles.boldH6,
                  ),
                  Text(
                    "Damascus - Syria",
                    style: AppFontStyles.regularH6
                        .copyWith(color: AppColors.kGreyColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMd().format(DateTime.now()),
                        style: AppFontStyles.regularH6
                            .copyWith(color: AppColors.kGreyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
