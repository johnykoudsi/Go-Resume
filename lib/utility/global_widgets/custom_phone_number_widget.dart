import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class PhoneTextField extends StatelessWidget {
  final ValueChanged<PhoneNumber> onPhoneNumberChanged;
  final TextEditingController phoneNumberController;
  final String? label;

  const PhoneTextField({
    super.key,
    this.label,
    required this.phoneNumberController,
    required this.onPhoneNumberChanged,
  });

  // static PhoneNumber? _currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: AppFontStyles.mediumH6),
        Container(
          // padding: const EdgeInsets.only(left: 12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white,
          ),
          child: InternationalPhoneNumberInput(
            countries: const ["AE", "QA", "SA", "EG", "JO", "SY"],
            onInputChanged: (phoneNumber) {
              onPhoneNumberChanged(phoneNumber);
            },
            searchBoxDecoration:  InputDecoration(
              contentPadding: EdgeInsets.only(top: 30),
              // hintText: "Search by country name or dial code",
              labelText: "Search by country name or dial code".tr(),
            ),
            // textStyle: AppFontStyles.regularH5,
            // .copyWith(color: AppColors.kTextField2Grey),
            initialValue: PhoneNumber(isoCode: "SY"),
            keyboardAction: TextInputAction.done,
            cursorColor: AppColors.kMainColor100,
            textFieldController: phoneNumberController,
            selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN),
          ),
        ),
      ],
    );
  }
}
