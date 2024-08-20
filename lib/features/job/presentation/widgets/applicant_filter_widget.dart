import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';

import '../../../../utility/app_strings.dart';


class ApplicantFilterWidget extends StatelessWidget {
  const ApplicantFilterWidget(
      {required this.onChanged, required this.value, Key? key})
      : super(key: key);
  final ApplicantTypes value;
  final Function(ApplicantTypes?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            "filters".tr(),
            style: AppFontStyles.regularH4,
          ),
        ),
        Column(
          children: List.generate(
            ApplicantTypes.values.length,
                (index) => RadioListTile(
                title: Text(
                  jobTypesUi.reverse[ApplicantTypes.values[index]] ?? '',
                ),
                value: ApplicantTypes.values[index],
                groupValue: value,
                onChanged: onChanged
            ),
          ),
        ),
      ],
    );
  }
}
