import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

class CustomFloatingButtonWidget extends StatelessWidget {
  final Icon icon;
  final void Function()? onPressed;
  const CustomFloatingButtonWidget(
      {Key? key, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.kSecondColor,
      child: icon,
    );
    //   FloatingActionButton(
    //   heroTag: null,
    //   onPressed: onPressed,
    //   backgroundColor:
    //       Colors.transparent, // Make the background color transparent
    //   elevation: 0, // Remove elevation
    //   child: Ink(
    //     decoration: const BoxDecoration(
    //       gradient: AppColors.kLinearColor,
    //     ),
    //     child: Container(
    //       width: double.infinity,
    //       height: double.infinity,
    //       alignment: Alignment.center,
    //       child: Text(
    //         title,
    //         style: AppFontStyles.mediumH4.copyWith(color: Colors.white),
    //       ),
    //     ),
    //   ),
    // );
  }
}
