import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/my_experineces/presentation/widgets/custom_experience_card.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/experience_widget.dart';

import '../../../../utility/global_widgets/custom_floating_button_widget.dart';

class MyExperiencesScreen extends StatefulWidget {
  const MyExperiencesScreen({Key? key}) : super(key: key);

  @override
  State<MyExperiencesScreen> createState() => _MyExperiencesScreenState();
}

List<ExperienceWidget> experiences = [
  const ExperienceWidget(
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan nibh non augue dignissim, quis fringilla nulla ullamcorper. Phasellus et augue eu nulla malesuada euismod.",
    role: 'Engineer',
    startDate: '5/2008',
    endDate: '6/2009',
    company: 'Google',
  ),
];

class _MyExperiencesScreenState extends State<MyExperiencesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Experiences",
          style: AppFontStyles.boldH1,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: experiences.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: CustomExperiencesCard(
              title: "Experience",
              operation: "Delete",
              experience: experiences[index],
            ),
          );
        },
      ),
      floatingActionButton:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           CustomFloatingButtonWidget(
            title: "AI",
          ),
           SizedBox(height: screenHeight*0.02,),
           CustomFloatingButtonWidget(
            title: "New",
          ),
        ],
      ),
    );
  }
}
