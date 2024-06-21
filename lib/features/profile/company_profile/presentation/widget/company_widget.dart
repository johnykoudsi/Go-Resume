import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';

import '../../../../../generated/assets.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({required this.user, super.key});
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
        Navigator.pushNamed(
          context,
          AppRoutes.companyProfile,
          arguments: user,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: ClipOval(
                child: FadeInImage(
                  fadeInDuration: const Duration(milliseconds: 100),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  placeholder: const AssetImage(Assets.jpgCompany),
                  image: NetworkImage(user.profileImage),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Assets.jpgCompany,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  user.fullName ?? '',
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  "Damascus - Syria",
                  style: AppFontStyles.regularH6
                      .copyWith(color: AppColors.kGreyColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
