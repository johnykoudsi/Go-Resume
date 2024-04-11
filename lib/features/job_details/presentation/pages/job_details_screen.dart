import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job_details/presentation/widgets/description_item_widget.dart';

class JobDetailsScreen extends StatefulWidget {

  const JobDetailsScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Software Engineer",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
        child: ListView(
          children: [
            Row(
              children: [
                const Text("Software Engineer", style: AppFontStyles.mediumH3),
                const Spacer(),
                Text(
                  "20/5/2023",
                  style: AppFontStyles.mediumH4
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
                  style: AppFontStyles.mediumH3.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Text(
                  "2,500,000 - 3,500,000 SYP",
                  style: AppFontStyles.mediumH3,
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
                      style: AppFontStyles.boldH5
                          .copyWith(color: AppColors.kGreenColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Container(
              height: screenWidth * 0.011, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.red, // Divider color
                borderRadius: BorderRadius.circular(
                    screenWidth * 0.01), // Rounded corners
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              children: [
                const Text("Work Hours Daily: ",style: AppFontStyles.mediumH3,),
                 Text("5 hours",style: AppFontStyles.mediumH3.copyWith(color: Colors.red),),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Text("Start date: ",style: AppFontStyles.mediumH3,),
                Text("28/5/2023",style: AppFontStyles.mediumH3.copyWith(color: Colors.red),),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Text("Experience Years: ",style: AppFontStyles.mediumH3,),
                Text("5 years",style: AppFontStyles.mediumH3.copyWith(color: Colors.red),),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Row(
              children: [
                const Text("Type: ",style: AppFontStyles.mediumH3,),
                Text("Full Time Contract",style: AppFontStyles.mediumH3.copyWith(color: Colors.red),),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              children: [
                Text("Description",style: AppFontStyles.boldH3.copyWith(color: Colors.red),),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            const Row(
              children: [
                Text("⚡",style: AppFontStyles.mediumH3,),
                Text("Requirements:",style: AppFontStyles.mediumH3,),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
             const DescriptionItemWidget(description: "More than ten years of expertise in the field of mobile development"),
             const DescriptionItemWidget(description: "Proficient in React Native with deep understanding of UX best practices"),
             const DescriptionItemWidget(description: "Understanding deeply on GraphQL, REST, the fundamentals of HTTP, and how to create stable APIs will be a plus."),
             const DescriptionItemWidget(description: "Experience designing consumer-facing iOS and Android applications at scale with a focus on organizational effect (More than 1M users is plus)"),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            ElevatedButtonWidget(title: "Apply",onPressed: (){},),

          ],
        ),
      ),
    );
  }
}
