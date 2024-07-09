import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';

import '../../../../utility/app_strings.dart';

class JobWidget extends StatelessWidget {
  final bool editable;
  final JobEntity jobEntity;
  const JobWidget({
    super.key,
    this.editable = false,
    required this.jobEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: const Color(0xff232323),
          animationDuration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.k15BorderRadius,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.jobDetails,
              arguments: jobEntity);
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              editable
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    )
                  : const SizedBox(),
              Text(
                jobEntity.position,
                style: AppFontStyles.boldH5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${NumberFormat.decimalPattern().format(jobEntity.minSalary)} ${"syp".tr()} - ${NumberFormat.decimalPattern().format(jobEntity.maxSalary)} ${"syp".tr()}",
                    style: AppFontStyles.mediumH6,
                  ),
                  Text(
                    jobTypesUi.reverse[jobEntity.type] ?? '',
                    style: AppFontStyles.mediumH5,
                  ),
                ],
              ),
              Text(
                jobTypesUi.reverse[jobEntity.type] ?? '',
                style: AppFontStyles.regularH6
                    .copyWith(color: AppColors.kGreyColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMd()
                        .format(jobEntity.startDate ?? DateTime(1970)),
                    style: AppFontStyles.regularH6
                        .copyWith(color: AppColors.kGreyColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
