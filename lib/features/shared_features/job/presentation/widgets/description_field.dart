import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class DescriptionField extends StatefulWidget {
  final String hintText;
  final TextInputType? textInputType;
  final int? fontSize;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool onlyNumber;
  final bool passwordBool;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function()? onTap;
  final bool enabled;
  final int? maxLength;
  final TextInputAction action;
  final int maxLines;
  final String? initValue;
  final String? label;

  const DescriptionField({
    this.label,
    this.initValue,
    this.action = TextInputAction.none,
    this.hintText = "",
    this.onChanged,
    this.textInputType,
    this.fontSize,
    required this.controller,
    this.validator,
    this.passwordBool = false,
    this.onlyNumber = false,
    this.onSubmit,
    this.onTap,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  _DescriptionFieldState createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              Text(widget.label!, style: AppFontStyles.mediumH6),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              height: 100,
              child: TextSelectionTheme(
                data: TextSelectionThemeData(
                  selectionColor: AppColors.fontColor.withOpacity(0.3),
                ),
                child: TextFormField(
                  maxLines: null, // Allows unlimited lines
                  expands: true, // Expands to fit content vertically
                  textAlignVertical: TextAlignVertical.top, // Align text to top
                  enabled: widget.enabled,
                  onFieldSubmitted: widget.onSubmit,
                  initialValue: widget.initValue,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                      color: AppColors.fontColor),
                  inputFormatters: widget.onlyNumber
                      ? <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.maxLength),
                  ]
                      : <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  validator: widget.validator,
                  controller: widget.controller,
                  obscureText: widget.passwordBool && !passwordVisible,
                  keyboardType: widget.textInputType,
                  cursorColor: AppColors.fontColor,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15, bottom: 15, top: 15, right: 15), // Increase padding to give more height
                    hintText: widget.hintText,
                    hintStyle: AppFontStyles.mediumH5.copyWith(color: AppColors.kGreyColor),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: AppBorders.k8BorderRadius,
                      borderSide: BorderSide(color: AppColors.kGreyColor),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: AppBorders.k8BorderRadius,
                      borderSide: BorderSide(color: AppColors.kGreyColor),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: AppBorders.k8BorderRadius,
                      borderSide: BorderSide(width: 2, color: AppColors.kGreyColor),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: AppBorders.k8BorderRadius,
                      borderSide: BorderSide(color: AppColors.kGreyColor),
                    ),
                    // Add suffixIcon based on passwordBool value
                    suffixIcon: widget.passwordBool
                        ? IconButton(
                      icon: Icon(
                        // Use appropriate icon based on obscureText value
                        passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.kGreyColor,
                      ),
                      onPressed: () {
                        // Toggle password visibility
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    )
                        : null,
                  ),
                  textInputAction: widget.action,
                  // Set the color of the selected text
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
