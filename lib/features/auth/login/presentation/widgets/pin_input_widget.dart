import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
const kElevation = 0.1;

class PinPutTheme{

  static const defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontWeight: AppFontWeight.bold, fontSize: 25),
    decoration: BoxDecoration(
      borderRadius: AppBorders.k8BorderRadius,
      boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          blurRadius: kElevation,
          offset: Offset(0, kElevation),
          color: Colors.white,// Shadow position, positive values mean the shadow will be below the widget
        ),
      ],
    ),
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
