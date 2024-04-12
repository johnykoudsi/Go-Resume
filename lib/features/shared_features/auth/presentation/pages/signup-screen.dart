import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import '../../../../../../core/router/app_routes.dart';
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
  String? _selectedUserType="Applicant";

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
                SizedBox(height: screenHeight*0.05,),
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
                  "Enter your information to signup",
                  style: AppFontStyles.mediumH6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // phone number text field
                    SizedBox(
                      height: screenHeight * 0.05,
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
                      hintText: 'Example: +96347924893',
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(height: heightBetweenFields,),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: nameController,
                      label: "Full Name",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Full Name is required";
                        }
                        return null;
                      },
                      hintText: 'Example: John Due',
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: false,
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
                      hintText: 'Example: 12345678a',
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: true,
                    ),

                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: repeatPasswordController,
                      label: "Repeat Password",
                      onlyNumber: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Repeat Password is required";
                        }
                        RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return 'Please Enter valid password';
                        }
                        if (passwordController.value != repeatPasswordController.value) {
                          return "Doesn't match";
                        }
                        return null;
                      },
                      hintText: 'Example: 12345678a',
                      textInputType: TextInputType.visiblePassword,
                      passwordBool: true,
                    ),
                    SizedBox(
                      height: heightBetweenFields*2,
                    ),
                    UserTypeWidget(selectedUserType: _selectedUserType, onUserTypeSelected: (value){setState(() {
                      _selectedUserType=value;
                    });})
                  ],
                ),
                SizedBox(height: screenHeight*0.05,),
                ElevatedButtonWidget(title: "Signup",onPressed: (){
                 Navigator.pushNamed(context, AppRoutes.verificationCode);
                },),
                SizedBox(height: screenHeight*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account?",style: AppFontStyles.mediumH4,),
                    GestureDetector(
                        onTap: (){Navigator.popAndPushNamed(context, AppRoutes.login);},
                        child: Text(" Login",style: AppFontStyles.mediumH4.copyWith(color: AppColors.kMainColor100),))
                  ],)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
