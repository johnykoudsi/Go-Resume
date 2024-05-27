import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({required this.user,super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
        Navigator.pushNamed(context, AppRoutes.companyProfile,  arguments: {
          'user': user,
          'visitor': true,
        },);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: AppColors.kBackGroundColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/M%C3%BCnster%2C_LVM%2C_B%C3%BCrogeb%C3%A4ude_--_2013_--_5149-51.jpg/1200px-M%C3%BCnster%2C_LVM%2C_B%C3%BCrogeb%C3%A4ude_--_2013_--_5149-51.jpg"),
                  fit: BoxFit.cover
                )
              ),
            ),
            Column(
              children: [
                Text(
                  user.fullName??'',
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  "Damascus - Syria",
                  style: AppFontStyles.regularH6.copyWith(color: AppColors.kGreyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
