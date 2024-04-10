import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_recruitment_flutter_user/features/auth/login/presentation/widgets/pin_input_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();

}
final controller = TextEditingController();
final focusNode = FocusNode();
class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                  "Please enter the 4-digit code sent to your",
                  textAlign: TextAlign.center,
                  style: AppFontStyles.mediumH3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "phone ",
                      textAlign: TextAlign.center,
                      style: AppFontStyles.mediumH3,
                    ),
                    Text(
                      "093 464 1049",
                      textAlign: TextAlign.center,
                      style: AppFontStyles.mediumH3.copyWith(color: AppColors.kMainColor100),
                    ),
                    const Text(
                      " for verification.",
                      textAlign: TextAlign.center,
                      style: AppFontStyles.mediumH3,
                    ),
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
              height: screenHeight * 0.18,
            ),
            ElevatedButtonWidget(
              title: 'Verify',
              onPressed: () {},
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text(
                    "Resend Code",
                    style: AppFontStyles.mediumH3,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
