import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import '../../../profile/presentation/widgets/skill_widget.dart';

class CustomSkillsCard extends StatelessWidget {
  final String title;
  final String operation;
  final SkillWidget skill;
  final VoidCallback? onOperationPressed;

  const CustomSkillsCard({
    Key? key,
    required this.title,
    required this.operation,
    required this.skill,
    this.onOperationPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(title: title, operation: operation, content: SkillWidget(
      skillName: skill.skillName,
      imagePath: skill.imagePath,
      description: skill.description,
    ),);
  }
}
