import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class UserTypeWidget extends StatelessWidget {
  final String? selectedUserType;
  final void Function(String?) onUserTypeSelected;

  const UserTypeWidget({super.key,
    required this.selectedUserType,
    required this.onUserTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<String>(
          value: 'Applicant',
          groupValue: selectedUserType,
          onChanged: onUserTypeSelected,
        ),
        const Text('Applicant',style: AppFontStyles.mediumH5,),
        Radio<String>(
          value: 'Company Recruiter',
          groupValue: selectedUserType,
          onChanged: onUserTypeSelected,
        ),
        const Text('Company Recruiter',style: AppFontStyles.mediumH5,),
      ],
    );
  }
}
