import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_style.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../../core/router/app_routes.dart';
import '../../../profile/presentation/widgets/custom_card_widget.dart';

class MySkillsScreen extends StatefulWidget {
  const MySkillsScreen({Key? key}) : super(key: key);

  @override
  State<MySkillsScreen> createState() => _MySkillsScreenState();
}

class _MySkillsScreenState extends State<MySkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Skills",style: AppFontStyles.boldH1,),
        iconTheme: const IconThemeData(size: 25,color: AppColors.fontColor),
      ),
      body:  ListView(
        children: [
          CustomCard(title:"Skill",operation: "Manage",onOperationPressed: (){ Navigator.of(context).pushNamed(AppRoutes.mySkills);},),
        ],
      ),
    );
  }
}
