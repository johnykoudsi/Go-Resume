import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';

class PreferredGenderWidget extends StatelessWidget {
  final GenderEnum? selectedPreferredGender;
  final void Function(GenderEnum?) onUserTypeSelected;

  const PreferredGenderWidget({super.key,
    required this.selectedPreferredGender,
    required this.onUserTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<GenderEnum>(
          toggleable: true,
          value: GenderEnum.m,
          groupValue: selectedPreferredGender,
          onChanged: onUserTypeSelected,
        ),
        const Text('Male',style: AppFontStyles.mediumH5,),
        Radio<GenderEnum>(
          toggleable: true,
          value: GenderEnum.f,
          groupValue: selectedPreferredGender,
          onChanged: onUserTypeSelected,
        ),
        const Text('Female',style: AppFontStyles.mediumH5,),
        // Radio<GenderEnum>(
        //   value:  GenderEnum.none,
        //   groupValue: selectedPreferredGender,
        //   onChanged: onUserTypeSelected,
        // ),
        // const Text('None',style: AppFontStyles.mediumH5,),
      ],
    );
  }
}
