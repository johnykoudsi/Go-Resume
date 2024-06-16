import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

class CustomNavigatorWidget extends StatelessWidget {
  CustomNavigatorWidget({
    Key? key,
    required this.selectedIndex,
    required this.widgetIndex,
    required this.svgPath,
  }) : super(key: key);

  final int selectedIndex;
  final int widgetIndex;

  String svgPath;
  @override
  Widget build(BuildContext context) {
    double getWidth = MediaQuery.of(context).size.width;
    return Container(
        height: getWidth * 0.1,
        width: getWidth * 0.1,
        decoration: BoxDecoration(
          borderRadius: AppBorders.k4BorderRadius,
          gradient:
              selectedIndex == widgetIndex ? AppColors.kLinearColor : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            svgPath,
            color: selectedIndex == widgetIndex
                ? Colors.white
                : AppColors.kMainColor100,
          ),
        ));
  }
}
