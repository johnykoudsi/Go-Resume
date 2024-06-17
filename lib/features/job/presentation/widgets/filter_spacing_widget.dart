import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';


class FilterSpacing extends StatelessWidget {
  const FilterSpacing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18,vertical: 18),
      child: Divider(
        height: 0,
        color: AppColors.kGreyColor,
        thickness: 0.8,
      ),
    );
  }
}
