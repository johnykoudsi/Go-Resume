import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/top_applicants_widget.dart';

import '../widgets/description_item_widget.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobEntity jobEntity;
  const JobDetailsScreen({required this.jobEntity, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
        child: ListView(
          children: [
            Row(
              children: [
                Text(jobEntity.position, style: AppFontStyles.mediumH5),
                const Spacer(),
                Text(
                  DateFormat.yMd()
                      .format(jobEntity.startDate ?? DateTime(1970)),
                  style: AppFontStyles.mediumH5
                      .copyWith(color: AppColors.kGreyColor),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                Text(
                  "Damascus-Syria-Company",
                  style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                Text(
                  "${NumberFormat.decimalPattern().format(jobEntity.minSalary)} SYP"
                  " - ${NumberFormat.decimalPattern().format(jobEntity.maxSalary)} SYP",
                  style: AppFontStyles.mediumH5,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      style: AppFontStyles.boldH7
                          .copyWith(color: AppColors.kGreenColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Container(
              height: screenWidth * 0.005, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.red, // Divider color
                borderRadius: BorderRadius.circular(
                    screenWidth * 0.01), // Rounded corners
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Text(
                  "Work Hours Daily: ",
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  jobEntity.workHours.toString(),
                  style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                const Text(
                  "Start date: ",
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  DateFormat.yMd()
                      .format(jobEntity.startDate ?? DateTime(1970)),
                  style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                const Text(
                  "Experience Years: ",
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  "${jobEntity.experienceYears} years",
                  style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              children: [
                const Text(
                  "Type: ",
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  jobEntity.type.name,
                  style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                Text(
                  "Description",
                  style: AppFontStyles.boldH5.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            const Row(
              children: [
                Text(
                  "⚡",
                  style: AppFontStyles.mediumH5,
                ),
                Text(
                  "Requirements:",
                  style: AppFontStyles.mediumH5,
                ),
              ],
            ),
            DescriptionItemWidget(description: jobEntity.description),
            const SizedBox(
              height: 100,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoggedState) {
                  if (state.user.data.applicant != null) {
                    return ElevatedButtonWidget(
                      title: "Apply",
                      onPressed: () {},
                    );
                  }
                  if (state.user.data.company != null) {
                    return Column(
                      children: [
                        Container(
                          height:
                              screenWidth * 0.011, // Adjust height as needed
                          decoration: BoxDecoration(
                            color: Colors.red, // Divider color
                            borderRadius: BorderRadius.circular(
                                screenWidth * 0.01), // Rounded corners
                          ),
                        ),
                        const TopApplicantsWidget(),
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
