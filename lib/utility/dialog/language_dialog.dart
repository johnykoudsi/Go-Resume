import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

class LanguageDialog {
  static void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          double getWidth = MediaQuery.of(context).size.width;
          String? radioValue = context.locale.languageCode;
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(getWidth * 0.038),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          activeColor: AppColors.kMainColor100,
                          title: const Text(
                            "English",
                          ),
                          value: "en",
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          }),
                      RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          activeColor: AppColors.kMainColor100,
                          title: const Text(
                            "العربية",
                          ),
                          value: "ar",
                          groupValue: radioValue,
                          onChanged: (value) {
                            setState(() {
                              radioValue = value;
                            });
                          }),
                      ElevatedButtonWidget(
                        title: 'Save'.tr(),
                        onPressed: () {
                          setState(() {
                            context.setLocale(Locale(radioValue ?? 'en'));
                            Navigator.of(context).pop();
                          });

                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
