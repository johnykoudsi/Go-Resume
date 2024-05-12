import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<dynamic> items;
  final dynamic? selectedItem;
  final void Function(dynamic)? onChanged;

  const CustomDropdown(
      {Key? key,
      required this.title,
      required this.items,
      required this.selectedItem,
      this.onChanged})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopupMenuButton<String>(
          offset: const Offset(0, 50),
          onSelected: widget.onChanged,
          itemBuilder: (BuildContext context) {
            return widget.items.map((item) {
              return PopupMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
                  style: AppFontStyles.mediumH3, // Increase font size for items
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
                  widget.selectedItem ?? widget.title,
                  style: AppFontStyles.mediumH3,
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
