import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'job_applicants_widget.dart';

class TopApplicantsWidget extends StatelessWidget {
  JobEntity jobEntity;
   TopApplicantsWidget({Key? key,required this.jobEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Applicants",
                  style: AppFontStyles.mediumH4.copyWith(fontSize: 22),
                ),
                TextButton(
                    onPressed: () {Navigator.pushNamed(context, AppRoutes.jobApplicants,
                      arguments: {
                        'jobEntity': jobEntity,
                      },
                    );},
                    child: Text(
                      "See All",
                      style: AppFontStyles.mediumH5
                          .copyWith(color: AppColors.kMainColor100),
                    ))
              ]),
       //   const JobApplicantsWidget(canReject: false,),
        //  const JobApplicantsWidget(canReject: false,),

        ],
      ),
    );
  }
}
