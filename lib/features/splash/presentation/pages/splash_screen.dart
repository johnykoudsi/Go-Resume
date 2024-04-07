import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/splash/presentation/widgets/splash_logo_widget.dart';

import '../../../../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        children: [
           SizedBox(
              height: screenHeight*0.9,
              width: screenWidth*0.8,
              child:  SplashLogoWidget()),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.025),
            child: Column(children: [
              SizedBox(height: screenHeight*0.05,),
              ElevatedButtonWidget(
                gradientColor: AppColors.kDarkLinearColor,
                  onPressed: (){},
                  title: "Login"),
              SizedBox(height: screenHeight*0.02,),
              ElevatedButtonWidget(
                  onPressed: (){},
                  title: "Signup"),
              SizedBox(height: screenHeight*0.08,),
            ],),
          )
        ],
      ),
    );
  }
}
