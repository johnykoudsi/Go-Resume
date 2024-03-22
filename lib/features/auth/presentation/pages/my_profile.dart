import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Container(
        height: screenHeight * 0.45,
        child: Stack(
          children: [
            // Cover Image
            Container(
              width: double.infinity,
              height: screenHeight * 0.35, // Adjust the height as per your design
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/jpg/cover_image.jpg'), // Replace with your cover image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Red Container
            Positioned(
              top: screenHeight * 0.35,
              left: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.08,
                decoration: const BoxDecoration(
                  gradient:
                  AppColors.kLinearColor
                ),
                // Other profile details can be added here
                // Add your profile details widgets (e.g., name, bio, etc.) below the red container
              ),
            ),
            // Profile Image
            Positioned(
              top: screenHeight * 0.25, // Adjust the position as per your design
              left: screenWidth / 2 - screenWidth*0.15, // Center horizontally
              child: Container(
                width: screenWidth*0.3,
                height: screenWidth*0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/jpg/profile_image.jpg'), // Replace with your profile image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.28, // Adjust the position as per your design
              left: screenWidth / 1.15 , // Center horizontally
              child: Container(
                width: screenWidth*0.1,
                height: screenWidth*0.1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.svgCamera, // Replace with your SVG image path
                    width: 24,
                    height: 24,
                    color: Colors.black, // Adjust icon color as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
