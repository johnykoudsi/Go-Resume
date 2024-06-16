import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

class ContactInfoWidget extends StatelessWidget {

  final String imagePath;

  const ContactInfoWidget({
    Key? key,

    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.1,
          height: screenWidth * 0.1,
          decoration:  const BoxDecoration(
            gradient: AppColors.kLinearColor,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            imagePath,
            width: screenWidth * 0.07,
            height: screenWidth * 0.07,
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
