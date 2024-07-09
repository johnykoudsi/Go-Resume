import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../../utility/app_strings.dart';

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
         Text("applicant".tr(),style: AppFontStyles.mediumH5,),
        Radio<String>(
          value: 'Company Recruiter',
          groupValue: selectedUserType,
          onChanged: onUserTypeSelected,
        ),
         Text("companyRecruiter".tr(),style: AppFontStyles.mediumH5,),
      ],
    );
  }
}
