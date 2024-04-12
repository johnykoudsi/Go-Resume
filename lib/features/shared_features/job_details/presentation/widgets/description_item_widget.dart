import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class DescriptionItemWidget extends StatelessWidget {
  final String description;
  const DescriptionItemWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Icon(Icons.square_rounded,color: AppColors.fontColor,size: 10,),
        SizedBox(width: screenWidth*0.03,),
        Container(
          constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
          child: Text(description,style: AppFontStyles.mediumH3,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
