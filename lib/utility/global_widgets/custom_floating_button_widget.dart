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
      key: UniqueKey(),
      heroTag: null,
      onPressed: onPressed,
      backgroundColor: AppColors.kSecondColor,
      child: icon,
    );
  }
}
