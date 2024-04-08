import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class Custom2 extends StatefulWidget {
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

  const Custom2({
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
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<Custom2> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            children: [
              Text(widget.label!, style: AppFontStyles.boldH4),
              const SizedBox(
                height: 0,
              ),
            ],
          ),
        TextFormField(
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          onFieldSubmitted: widget.onSubmit,
          initialValue: widget.initValue,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          style: const TextStyle(color: AppColors.fontColor),
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
          cursorColor: AppColors.kMainColor100,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15, bottom: 0, top: 0, right: 15),
            hintText: widget.hintText,
            hintStyle: AppFontStyles.regularH4.copyWith(color: AppColors.kTextField2Grey),
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
        ),
      ],
    );
  }
}
