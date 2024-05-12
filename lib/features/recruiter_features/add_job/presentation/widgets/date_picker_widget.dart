import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const DatePickerWidget({Key? key, required this.label, required this.controller, this.validator}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true, // Show the bottom sheet as a modal popup
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3, // Adjust the height as needed
          child: CupertinoDatePicker(
            // minimumDate:_selectedDate ?? DateTime.now().add(const Duration(days: 1)), // Set minimum date to tomorrow
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
                widget.controller.text =newDate.toString();
                //'${newDate.day}/${newDate.month}/${newDate.year}';
              });
            },
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.controller.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
                icon:  Icon(Icons.calendar_month,color: _selectedDate==null? AppColors.kGreyColor:AppColors.kMainColor100,),
                onPressed: () => _selectDate(context),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust padding as needed
                    child: Text(
                      _selectedDate != null ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}' : 'Select a date',
                      style: TextStyle(
                        color: _selectedDate != null ? Colors.black : AppColors.kGreyColor,
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
