import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/app_style.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.45,
              child: Stack(
                children: [
                  // Cover Image
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/jpg/cover_image.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.35,
                    left: 0,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.08,
                      decoration:
                          const BoxDecoration(gradient: AppColors.kLinearColor),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.25,
                    left: screenWidth / 2 - screenWidth * 0.15,
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/jpg/profile_image.jpg'), // Replace with your profile image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.28,
                    left: screenWidth / 1.12,
                    child: Container(
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.imagesSvgCamera,
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.07,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.35,
                    left: screenWidth / 1.7,
                    child: Container(
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.imagesSvgCamera,
                          width: screenWidth * 0.06,
                          height: screenWidth * 0.06,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.36,
                    left: screenWidth / 1.12,
                    child: SvgPicture.asset(
                      Assets.svgEdit,
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      top: screenHeight * 0.38,
                      left: screenWidth / 18,
                      child: const Text("55 Views",
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            const Text(
              "John Doe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(height: screenHeight*0.02,),
            Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),

                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
              child: const Column(
                children: [
                  Row(
                    children: [Text("")],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
