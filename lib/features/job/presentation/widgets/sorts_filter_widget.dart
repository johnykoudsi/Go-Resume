import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/filter_spacing_widget.dart';
import 'handle_widget.dart';

class SortsFilterWidget extends StatelessWidget {
  SortsFilterWidget({required this.onChanged,required this.value,Key? key}) : super(key: key);

  JobSorts value;
  Function(JobSorts?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HandleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 18),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22),
                  child: Text(
                    "Sorts".tr(),
                    style: AppFontStyles.regularH4,

                  ),
                ),
                Column(
                  children: List.generate(
                    JobSorts.values.length,
                        (index) => RadioListTile(
                      title: Text(
                        jobSortsUi.reverse[
                        JobSorts.values[index]] ?? '',
                      ),
                      value:
                      JobSorts.values[index],
                      groupValue: value,
                      onChanged: onChanged,
                    ),
                  ),
                ),
                const FilterSpacing(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
