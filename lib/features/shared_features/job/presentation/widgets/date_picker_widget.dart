import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class DatePickerWidget extends StatelessWidget {
  final String label;
  final Function(DateTime) onDateChange;
  final DateTime? selectedDate;

  const DatePickerWidget({
    Key? key,
    required this.label,
    required this.selectedDate,
    required this.onDateChange,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true, // Show the bottom sheet as a modal popup
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height *
              0.3, // Adjust the height as needed
          child: CupertinoDatePicker(
            // minimumDate: DateTime.now().add(const Duration(days: 1)),
            maximumDate: DateTime.now().add(const Duration(days: 360)),
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            onDateTimeChanged: onDateChange,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFontStyles.mediumH6,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kGreyColor),
            borderRadius: AppBorders.k8BorderRadius,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: selectedDate == null
                      ? AppColors.kGreyColor
                      : AppColors.kMainColor100,
                ),
                onPressed: () => _selectDate(context),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0), // Adjust padding as needed
                    child: Text(
                      selectedDate != null
                          ? DateFormat.yMd().format(selectedDate!)
                          : "Select Date",
                      style: TextStyle(
                        color: selectedDate != null
                            ? Colors.black
                            : AppColors.kGreyColor,
                        fontSize: 16.0, // Adjust font size as needed
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
