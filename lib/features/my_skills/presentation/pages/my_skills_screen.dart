import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/my_skills/presentation/widgets/custom_skills_card.dart';
import '../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../profile/presentation/widgets/skill_widget.dart';

class MySkillsScreen extends StatefulWidget {
  const MySkillsScreen({Key? key}) : super(key: key);


  @override
  State<MySkillsScreen> createState() => _MySkillsScreenState();
}
List<SkillWidget> skills = [
  const SkillWidget(
    skillName: "Microsoft Word",
    imagePath: "assets/images/svg/case.svg",
    description: "Computer Skill",
  ),
  const SkillWidget(
    skillName: "Microsoft Word",
    imagePath: "assets/images/svg/case.svg",
    description: "Computer Skill",
  ),
];

class _MySkillsScreenState extends State<MySkillsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Skills",style: AppFontStyles.boldH2,),
        iconTheme: const IconThemeData(size: 25,color: AppColors.fontColor),
      ),
      body:  ListView.builder(
        itemCount: skills.length,
        itemBuilder: (BuildContext context, int index) {
         return
           Padding(
             padding:  EdgeInsets.only(top: screenHeight*0.02),
             child: CustomSkillsCard(title:"Skill",operation: "Delete",skill: skills[index],),
           );
        },
      ),
      floatingActionButton: const CustomFloatingButtonWidget(title: "New",),
    );
  }
}
