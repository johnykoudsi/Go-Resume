import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/entities/job_entity.dart';
import '../../../../shared_features/job_details/presentation/pages/job_details_screen.dart';


class JobWidget extends StatelessWidget {
  final bool editable;
  final Job job;
  const JobWidget({super.key,
     this.editable=false, required this.job,
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
          Navigator.push(context ,  MaterialPageRoute(
            builder: (context) => JobDetailsScreen(canApply: !editable), // or false based on your logic
          ),
          );

        },
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    job.id.toString(),
                    style: AppFontStyles.mediumH5,
                  ),
                  editable==true ?
                  IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
                      : const Text(""),
                ],
              ),
              const Text(
                "Software Engineer",
                style: AppFontStyles.boldH5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "4,500,000 SYP",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "Remote",
                    style: AppFontStyles.mediumH5,
                  ),
                ],
              ),
              Text(
                "Damascus - Syria - Company",
                style: AppFontStyles.regularH6
                    .copyWith(color: AppColors.kGreyColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    DateFormat.yMd().format(DateTime.now()),
                    style: AppFontStyles.regularH6
                        .copyWith(color: AppColors.kGreyColor),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.fiber_manual_record,
                        size: 10,
                        color: AppColors.kGreenColor,
                      ),
                      const SizedBox(width: 2,),
                      Text(
                        "Open",
                        style: AppFontStyles.boldH5.copyWith(color: AppColors.kGreenColor),
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
