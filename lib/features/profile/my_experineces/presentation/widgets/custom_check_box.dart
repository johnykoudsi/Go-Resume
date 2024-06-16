import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomCheckBox({super.key, required this.text, required this.isChecked, required this.onChanged});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Checkbox(
          side: const BorderSide(
            color: AppColors.kGreyColor,
          ),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
              widget.onChanged(value);
            });
          },
        ),
        Text(widget.text,
        style: AppFontStyles.mediumH5,
        ),
      ],
    );
  }
}
