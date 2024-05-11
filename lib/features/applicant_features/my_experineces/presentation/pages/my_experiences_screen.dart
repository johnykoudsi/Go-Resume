import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';

import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../shared_features/applicant_profile/presentation/widgets/experience_widget.dart';
import '../widgets/custom_experience_card.dart';


class MyExperiencesScreen extends StatefulWidget {
  const MyExperiencesScreen({required this.experiences,Key? key}) : super(key: key);
final List<Experience> experiences;
  @override
  State<MyExperiencesScreen> createState() => _MyExperiencesScreenState();
}

class _MyExperiencesScreenState extends State<MyExperiencesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Experiences",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: widget.experiences.length,
        itemBuilder: (BuildContext context, int index1) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
           child:  CustomCard(
              title: "Experiences",
              content: Column(
                children: List.generate(
                     1,
                      (index) {
                    Experience? e = widget.experiences?[index1];
                    return ExperienceWidget(
                      experience: e!,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CustomFloatingButtonWidget(
            title: "AI",
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
           CustomFloatingButtonWidget(
            onPressed: (){Navigator.pushNamed(context, AppRoutes.addExperience);},
            title: "New",
          ),
        ],
      ),
    );
  }
}
