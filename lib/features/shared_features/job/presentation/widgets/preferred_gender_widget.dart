import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class PreferredGenderWidget extends StatelessWidget {
  final String? selectedPreferredGender;
  final void Function(String?) onUserTypeSelected;

  const PreferredGenderWidget({super.key,
    required this.selectedPreferredGender,
    required this.onUserTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<String>(
          value: 'Male',
          groupValue: selectedPreferredGender,
          onChanged: onUserTypeSelected,
        ),
        const Text('Male',style: AppFontStyles.mediumH4,),
        Radio<String>(
          value: 'Female',
          groupValue: selectedPreferredGender,
          onChanged: onUserTypeSelected,
        ),
        const Text('Female',style: AppFontStyles.mediumH4,),
        Radio<String>(
          value: 'None',
          groupValue: selectedPreferredGender,
          onChanged: onUserTypeSelected,
        ),
        const Text('None',style: AppFontStyles.mediumH4,),
      ],
    );
  }
}
