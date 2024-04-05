import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class CustomFloatingButtonWidget extends StatelessWidget {
  final String title;
  const CustomFloatingButtonWidget({Key? key,
  required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth*0.17, // Adjust width as needed
      height: screenWidth*0.17, // Adjust height as needed
      child: FloatingActionButton(
        onPressed: () {
          // Your onPressed logic here
        },
        backgroundColor: Colors.transparent, // Make the background color transparent
        elevation: 0, // Remove elevation
        shape: const CircleBorder(), // Set shape to circular
        child: Ink(
          decoration: const BoxDecoration(
            gradient: AppColors.kLinearColor,
            shape: BoxShape.circle, // Ensure the decoration shape is circular
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppFontStyles.mediumH4.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
