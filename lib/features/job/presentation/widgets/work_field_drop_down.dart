import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';

class WorkFieldDropDownListWidget extends StatelessWidget {
  WorkFieldDropDownListWidget(
      {
        required this.dropDownValues,
        required this.onChanged,
        required this.value,
        required this.hint,
        Key? key})
      : super(key: key);

  Function(Object?)? onChanged;
  dynamic value;
  String hint;
  List<dynamic>? dropDownValues;

  @override
  Widget build(BuildContext context) {
    double getWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: AppBorders.k4BorderRadius,
        color: Colors.white,
      ),
      child: DropdownButton(
          underline: Container(),
          isExpanded: true,
          dropdownColor: Colors.white,
          focusColor: Colors.white,
          borderRadius: AppBorders.k4BorderRadius,
          elevation: 0,
          alignment: Alignment.center,
          menuMaxHeight: 225,
          hint: Text(
            hint,
          ),
          value: value,
          items: dropDownValues?.map((items) {
            return DropdownMenuItem(
              alignment: Alignment.center,
              value: items,
              child: Text(
                items.name,
              ),
            );
          }).toList(),
          onChanged: onChanged),
    );
  }
}
