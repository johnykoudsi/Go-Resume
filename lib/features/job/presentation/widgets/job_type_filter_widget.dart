import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';

import '../../../../utility/app_strings.dart';


class JobTypeFilterWidget extends StatelessWidget {
  const JobTypeFilterWidget(
      {required this.onChanged, required this.value, Key? key})
      : super(key: key);
  final JobTypes value;
  final Function(JobTypes?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            "jobType".tr(),
            style: AppFontStyles.regularH4,
          ),
        ),
        Column(
          children: List.generate(
            JobTypes.values.length,
                (index) => RadioListTile(
                title: Text(
                  jobTypesUi.reverse[JobTypes.values[index]] ?? '',
                ),
                value: JobTypes.values[index],
                groupValue: value,
                onChanged: onChanged
            ),
          ),
        ),
      ],
    );
  }
}
