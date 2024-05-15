import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class SkillDropdownList extends StatelessWidget {
  final String title;
  final Skill? selectedItem;
  final void Function(Skill)? onChanged;
  final List<Skill> allSkills;
  const SkillDropdownList(
      {Key? key,
        required this.title,
        required this.selectedItem,
        required this.allSkills,
        this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<Skill>(
          offset: const Offset(0, 50),
          onSelected: onChanged,
          constraints: const BoxConstraints.expand(width: 500, height: 300),

          itemBuilder: (BuildContext context) {
            return allSkills.map((item) {
              return PopupMenuItem<Skill>(
                value: item,
                child: Text(
                  item.name,
                  style: AppFontStyles.mediumH5, // Increase font size for items
                ),
              );
            }).toList();
          }, // Adjust the offset to position the dropdown below the container
          child: Container(
            height: 50,
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.kGreyColor),
              borderRadius: AppBorders.k8BorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppFontStyles.mediumH5,
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
