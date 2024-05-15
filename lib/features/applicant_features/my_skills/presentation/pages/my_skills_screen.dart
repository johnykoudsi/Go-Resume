import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/applicant_profile/presentation/widgets/skill_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_floating_button_widget.dart';

class MySkillsScreen extends StatefulWidget {
  const MySkillsScreen({required this.skills, Key? key}) : super(key: key);
  final List<Skill> skills;
  @override
  State<MySkillsScreen> createState() => _MySkillsScreenState();
}

class _MySkillsScreenState extends State<MySkillsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Skills",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: widget.skills.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: SkillWidget(
              skill: widget.skills[index],
            ),
          );
        },
      ),
      floatingActionButton: const CustomFloatingButtonWidget(
        icon: Icon(Icons.add),
      ),
    );
  }
}
