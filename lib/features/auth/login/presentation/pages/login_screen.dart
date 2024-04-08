import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                SizedBox(height: screenHeight*0.1,),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return AppColors.kLinearColor.createShader(bounds);
                  },
                  child: const Text(
                    "Welcome",
                    style: AppFontStyles.boldH1,
                  ),
                ),
                const Text(
                  "Enter your phone number to login",
                  style: AppFontStyles.mediumH6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // phone number text field
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),


                    // password text field
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: phoneController,
                      label: "Phone Number",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Number is required";
                        }
                        return null;
                      },
                      hintText: '+96347924893',
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(height: heightBetweenFields,),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: passwordController,
                      label: "Password",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return 'Please Enter valid password';
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
                SizedBox(height: screenHeight*0.1,),

                ElevatedButtonWidget(title: "Login",onPressed: (){},),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
