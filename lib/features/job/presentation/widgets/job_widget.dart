import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import '../pages/job_details_screen.dart';

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
                        Spacer(),
                             IconButton(
                                onPressed: () {}, icon: const Icon(Icons.edit))
                      ],
                    )
                  : SizedBox(),
              Text(
                jobEntity.position,
                style: AppFontStyles.boldH5,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    jobEntity.maxSalary.toString()+"  SYP",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    jobEntity.type.name??"Remote",
                    style: AppFontStyles.mediumH5,
                  ),
                ],
              ),
              Text(
                jobEntity.type.name ?? "Remote",
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
                  Row(
                    children: [
                      const Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: AppColors.kGreenColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Open",
                        style: AppFontStyles.boldH5
                            .copyWith(color: AppColors.kGreenColor),
                      ),
                    ],
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
