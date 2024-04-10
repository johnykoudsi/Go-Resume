import 'package:flutter/material.dart';

import '../../../../../utility/global_widgets/custom_card.dart';
import '../../../profile/presentation/widgets/experience_widget.dart';
class CustomExperiencesCard extends StatelessWidget {
  const CustomExperiencesCard(
      {Key? key,
      required this.title,
      required this.operation,
      required this.experience,
      this.onOperationPressed})
      : super(key: key);
  final String title;
  final String operation;
  final ExperienceWidget experience;
  final VoidCallback? onOperationPressed;
  @override
  Widget build(BuildContext context) {
    return CustomCard(title: title, operation: operation, content: ExperienceWidget(
        description: experience.description,
        role: experience.role,
        startDate: experience.startDate,
        endDate: experience.endDate,
        company: experience.company),
         );

  }
}
