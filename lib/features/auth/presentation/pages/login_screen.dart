import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_phone_number_widget.dart';

import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../utility/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  PhoneNumber? phoneNumberValue;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoggedState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              state.user.data.company == null
                  ? AppRoutes.bottomNavBarScreen
                  : AppRoutes.recruiterBottomNavBar,
              (Route<dynamic> route) => false);
        }
        if (state is UserErrorState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
              context: context,
              helperResponse: state.helperResponse,
              showServerError: true);
        }
      },
      child: Scaffold(
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
                    height: screenHeight * 0.1,
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return AppColors.kLinearColor.createShader(bounds);
                    },
                    child:  Text(
                      AppStrings.welcome,
                      style: AppFontStyles.boldH1,
                    ),
                  ),
                   Text(
                    AppStrings.enterPhoneNumber,
                    style: AppFontStyles.mediumH6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // phone number text field
                      SizedBox(
                        height: screenHeight * 0.1,
                      ),
                      PhoneTextField(
                        phoneNumberController: phoneController,
                        label: "${AppStrings.phoneNumber}*",
                        onPhoneNumberChanged: (PhoneNumber value) {
                          phoneNumberValue = value;
                        },
                      ),
                      SizedBox(
                        height: heightBetweenFields,
                      ),
                      CustomTextField(
                        action: TextInputAction.done,
                        controller: passwordController,
                        label: "${AppStrings.password}*",
                        onlyNumber: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.password+AppStrings.isRequired;
                          }
                          RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
                          if (!regex.hasMatch(value)) {
                            return AppStrings.enterValidPassword;
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
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return ElevatedButtonWidget(
                        title: AppStrings.login,
                        isLoading: state is UserLoading,
                        onPressed: () async {
                          // final _firebaseMessaging = FirebaseMessaging.instance;
                          // await _firebaseMessaging.requestPermission();
                          // String? fcmToken = await _firebaseMessaging.getToken();
                          if (!_key.currentState!.validate()) {
                            return;
                          }
                          context.read<UserBloc>().add(LoginUserEvent(
                                password: passwordController.text,
                                phoneNumber: phoneNumberValue!.phoneNumber!
                                    .replaceAll("+", ""),
                                //      fcm_token: fcmToken
                              ));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        AppStrings.dontHaveAccount,
                        style: AppFontStyles.mediumH5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(
                                context, AppRoutes.signup);
                          },
                          child: Text(
                            " ${AppStrings.signup}",
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
      ),
    );
  }
}
