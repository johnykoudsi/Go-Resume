
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';

class ReportCategoryDropDown extends StatelessWidget {
  final String title;
  final dynamic selectedItem;
  final void Function(ReportCategory)? onChanged;

  const ReportCategoryDropDown(
      {Key? key,
        required this.title,
        required this.selectedItem,
        this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<ReportCategory>(
          offset: const Offset(0, 50),
          onSelected: onChanged,
          itemBuilder: (BuildContext context) {
            return ReportCategory.values.map((item) {
              return PopupMenuItem<ReportCategory>(
                value: item,
                child: Text(
                  reportTypesUi.reverse[item] ?? "",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reportTypesUi.reverse[selectedItem] ?? title,
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
