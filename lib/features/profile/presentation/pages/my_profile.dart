import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../widgets/CustomCard.dart';
import '../widgets/Skill.dart';
import '../widgets/job.dart';

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
    List<Job> jobs = [
      const Job(
        role: "Software Engineer",
        startDate: "5/2022",
        endDate: "5/2023",
        company: "Tech Company",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan nibh non augue dignissim, quis fringilla nulla ullamcorper. Phasellus et augue eu nulla malesuada euismod.",
      ),
      const Job(
        role: "Another Role",
        startDate: "6/2023",
        endDate: "8/2024",
        company: "Another Company",
        description: "Another description goes here.",
      ),
    ];
    List<Skill> skills = [
      const Skill(
        skillName: "Microsoft Word",
        imagePath: "assets/images/svg/case.svg",
        description: "Computer Skill",
      ),
      const Skill(
        skillName: "Python",
        imagePath: "assets/images/svg/case.svg",
        description: "Programming Language",

      ),
      const Skill(
        skillName: "Scrum",
        imagePath: "assets/images/svg/case.svg",
        description: "Team Skill",
      ),
      // Add more skills as needed
    ];
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
                          Assets.svgCamera,
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
                          Assets.svgCamera,
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
            Text(
              "John Doe",
              style: AppFontStyles.boldH2.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomCard(title:"Experiences",operation: "Manage",jobs: jobs),
            SizedBox(height: screenHeight*0.02,),
            CustomCard(title:"Skills",operation: "Manage",skills: skills),
          ],
        ),
      ),
    );
  }
}
