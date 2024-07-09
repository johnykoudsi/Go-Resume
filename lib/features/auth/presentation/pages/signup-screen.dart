import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_phone_number_widget.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../utility/app_strings.dart';
import '../widgets/user_type_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  String? _selectedUserType = "Applicant";
  PhoneNumber? phoneNumberValue;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return Scaffold(
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.03),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return AppColors.kLinearColor.createShader(bounds);
                  },
                  child:  Text(
                    "welcome".tr(),
                    style: AppFontStyles.boldH1,
                  ),
                ),
                 Text(
                  "enterInformation".tr(),
                  style: AppFontStyles.mediumH6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // phone number text field
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    PhoneTextField(
                      phoneNumberController: phoneController,
                      label: "${"phoneNumber".tr()}*",
                      onPhoneNumberChanged: (PhoneNumber value) {
                        phoneNumberValue = value;
                      },
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: nameController,
                      label: "${"fullName".tr()}*",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "fullName".tr()+"isRequired".tr();
                        }
                        return null;
                      },
                      hintText: "johnDue".tr(),
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: false,
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: passwordController,
                      label: "${"password".tr()}*",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "password".tr()+"isRequired".tr();
                        }
                        RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return "enterValidPassword".tr();
                        }
                        return null;
                      },
                      hintText: '12345678a',
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: true,
                    ),

                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: repeatPasswordController,
                      label: "${"repeatPassword".tr()}*",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "repeatPassword".tr()+"isRequired".tr();
                        }
                        RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return "enterValidPassword".tr();
                        }
                        if (passwordController.value !=
                            repeatPasswordController.value) {
                          return "doesNotMatch".tr();
                        }
                        return null;
                      },
                      hintText: '12345678a',
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: true,
                    ),
                    SizedBox(
                      height: heightBetweenFields * 2,
                    ),
                    UserTypeWidget(
                        selectedUserType: _selectedUserType,
                        onUserTypeSelected: (value) {
                          setState(() {
                            _selectedUserType = value;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                ElevatedButtonWidget(
                    title: "signup".tr(),
                    onPressed: () {
                      if (!_key.currentState!.validate()) {
                        return;
                      }
                      context.read<UserBloc>().add(
                            SendSMSEvent(
                              phoneNumber: phoneNumberValue!.phoneNumber!
                                  .replaceAll("+", ""),
                            ),
                          );
                      Navigator.of(context).pushNamed(
                          AppRoutes.verificationCode,
                          arguments: SignUpEvent(
                            password: passwordController.text,
                            phoneNumber: phoneNumberValue!.phoneNumber!
                                .replaceAll("+", ""),
                            fullName: nameController.text,
                            verificationCode: "0000",
                            isCompany:
                                _selectedUserType == "Applicant" ? false : true,
                          ));
                    }),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                     "haveAccount".tr(),
                      style: AppFontStyles.mediumH5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, AppRoutes.login);
                        },
                        child: Text(
                          " ${"login".tr()}",
                          style: AppFontStyles.mediumH5
                              .copyWith(color: AppColors.kMainColor100),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
