import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';

import '../widgets/count_down_timer_widget.dart';
import '../widgets/pin_input_widget.dart';

class CodeVerificationScreenPage extends StatefulWidget {
  CodeVerificationScreenPage({required this.signUpEvent, Key? key})
      : super(key: key);

  SignUpEvent signUpEvent;
  @override
  State<CodeVerificationScreenPage> createState() =>
      _CodeVerificationScreenPagePageState();
}

class _CodeVerificationScreenPagePageState
    extends State<CodeVerificationScreenPage> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  final focusNode = FocusNode();
  bool canTapResend = true;
  bool canTapResend2 = true;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if(state is UserLoggedState){
            Navigator.of(context).pushNamedAndRemoveUntil(
                widget.signUpEvent.isCompany==false?
              AppRoutes.bottomNavBarScreen:AppRoutes.recruiterBottomNavBar

                ,(Route<dynamic> route) => false);
          }
          if(state is UserErrorState){
            DialogsWidgetsSnackBar.showSnackBarFromStatus(
                context: context,
                helperResponse: state.helperResponse,
                showServerError: true
            );
          }
        },
        child:  SafeArea(
          child: ListView(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
                screenWidth * 0.04, screenWidth * 0.03),
            children: [
              SizedBox(height: screenHeight * 0.1),
              Center(
                child:ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return AppColors.kLinearColor.createShader(bounds);
                  },
                  child: const Text(
                    "Verify Your Number",
                    style: AppFontStyles.boldH1,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Column(
                children: [
                  const Text(
                    "Please enter the 4-digit code sent to",
                    textAlign: TextAlign.center,
                    style: AppFontStyles.mediumH3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Text(
                      //   "phone ",
                      //   textAlign: TextAlign.center,
                      //   style: AppFontStyles.mediumH3,
                      // ),
                      Text(
                        widget.signUpEvent.phoneNumber,
                        textAlign: TextAlign.center,
                        style: AppFontStyles.mediumH3.copyWith(color: AppColors.kMainColor100),
                      ),
                      // const Text(
                      //   " for verification.",
                      //   textAlign: TextAlign.center,
                      //   style: AppFontStyles.mediumH3,
                      // ),
                    ],
                  ),

                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                ],
              ),
              Pinput(
                length: 4,
                pinAnimationType: PinAnimationType.slide,
                controller: controller,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
                defaultPinTheme: PinPutTheme.defaultPinTheme,
                showCursor: true,
                cursor: PinPutTheme.cursor,
                preFilledWidget: PinPutTheme.preFilledWidget,
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return ElevatedButtonWidget(
                    title: 'Verify'.tr(),
                    isLoading: state is UserLoading,
                    onPressed: controller.text.isEmpty
                        ? null
                        : () {
                      widget.signUpEvent.verificationCode =
                          controller.text;

                      context.read<UserBloc>().add(widget.signUpEvent);
                    },
                  );
                },
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn’t receive any code? ",
                        style: AppFontStyles.mediumH4,
                      ),
                      Text(
                        "Resend Code",
                        style: AppFontStyles.mediumH4.copyWith(color: AppColors.kMainColor100),
                      ),
                    ],
                  ),
                  const CountdownTimer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
