import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class PinPutTheme{
  static const defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontWeight: AppFontWeight.bold,fontSize: 25),
    decoration: BoxDecoration(borderRadius: AppBorders.k8BorderRadius),
  );

  static final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
  static final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 56,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.kMainColor100,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );
}
