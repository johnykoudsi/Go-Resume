import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../generated/assets.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Stack(
      children: [
        Positioned(
          top: screenHeight*0.2,
          child: SvgPicture.asset(
            Assets.svgSplashScreenEmployee,
            width: screenWidth,
            height: screenHeight * 0.9,
          ),
        ),
        Positioned(
          top: screenHeight*0.2,
          left: screenWidth*0.1,
          right: screenWidth*0.1,
          child: Image(
            image: const AssetImage(Assets.pngGoResumeLogo),
            width: screenWidth * 0.8,
          ),
        ),
      ],
    );
  }
}
