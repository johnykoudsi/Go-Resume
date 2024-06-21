import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/pages/job_applicants_screen.dart';

import '../../../../utility/app_strings.dart';
import 'job_applicants_widget.dart';

class TopApplicantsWidget extends StatelessWidget {
  JobEntity jobEntity;
  List<User> applicants;
   TopApplicantsWidget({Key? key,required this.jobEntity,required this.applicants}) : super(key: key);

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
                  AppStrings.applicants,
                  style: AppFontStyles.mediumH4.copyWith(fontSize: 20),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.jobApplicants,arguments: jobEntity);

                      // Navigator.push(context ,  MaterialPageRoute(
                      //   builder: (context) =>  JobApplicantsScreen(jobEntity: jobEntity,), // or false based on your logic
                      // ),
                      // );
                      },
                    child: Text(
                      "See All",
                      style: AppFontStyles.mediumH4.copyWith(fontSize: 20)
                          .copyWith(color: AppColors.kMainColor100),
                    ))
              ]),

          Container(
            height: 200,
            child: ListView.builder(
              itemCount: applicants.length,
              itemBuilder: (BuildContext context, int index) {
                if (applicants != []) {
                  return JobApplicantsWidget(
                    job: jobEntity,
                    canReject: false,
                    applicant: applicants[index],
                  );
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}
