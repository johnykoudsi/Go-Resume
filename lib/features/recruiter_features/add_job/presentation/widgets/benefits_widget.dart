import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class BenefitsWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String description;

  const BenefitsWidget({Key? key, this.onPressed,  required this.description}) : super(key: key);

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
          borderRadius: AppBorders.k8BorderRadius,
        ),
      ),
      onPressed: onPressed, // Assign the onPressed function to the button
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Benefits",
                  style: AppFontStyles.mediumH3,
                ),
              ],
            ),
            Text(
              description,
              style: AppFontStyles.mediumH4.copyWith(color: AppColors.kGreyColor),
            ),
          ],
        ),
      ),
    );
  }
}