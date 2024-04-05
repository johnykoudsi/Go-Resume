import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/contact_info_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../../../../core/router/app_routes.dart';
import '../widgets/custom_card_widget.dart';
import '../widgets/education_and_certificates_widget.dart';
import '../widgets/profile_image_widget.dart';
import '../widgets/skill_widget.dart';
import '../widgets/experience_widget.dart';

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
    List<ExperienceWidget> jobs = [
      const ExperienceWidget(
        role: "Software Engineer",
        startDate: "5/2022",
        endDate: "5/2023",
        company: "Tech Company",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan nibh non augue dignissim, quis fringilla nulla ullamcorper. Phasellus et augue eu nulla malesuada euismod.",
      ),
      const ExperienceWidget(
        role: "Another Role",
        startDate: "6/2023",
        endDate: "8/2024",
        company: "Another Company",
        description: "Another description goes here.",
      ),
    ];
    List<SkillWidget> skills = [
      const SkillWidget(
        skillName: "Microsoft Word",
        imagePath: "assets/images/svg/case.svg",
        description: "Computer Skill",
      ),
      const SkillWidget(
        skillName: "Python",
        imagePath: "assets/images/svg/case.svg",
        description: "Programming Language",

      ),
      const SkillWidget(
        skillName: "Scrum",
        imagePath: "assets/images/svg/case.svg",
        description: "Team Skill",
      ),
    ];
    List<EducationAndCertificatesWidget> educationAndCertificates = [
      const EducationAndCertificatesWidget(
        specialization: "Bachelor of Science in Computer Science",
        startDate: "2018",
        endDate: "2022",
        organization: "University of XYZ",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
      const EducationAndCertificatesWidget(
        specialization: "Master of Business Administration",
        startDate: "2022",
        endDate: "2024",
        organization: "ABC Business School",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
      const EducationAndCertificatesWidget(
        specialization: "Certificate in Graphic Design",
        startDate: "2020",
        endDate: "2021",
        organization: "Design Academy",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
    ];
    List<ContactInfoWidget> contacts = [
      const ContactInfoWidget(
        imagePath: "assets/images/svg/facebook.svg",
      ),
      const ContactInfoWidget(
        imagePath: "assets/images/svg/telegram.svg",
      ),
      const ContactInfoWidget(
        imagePath: "assets/images/svg/phone.svg",
      ),
      const ContactInfoWidget(
        imagePath: "assets/images/svg/whatsapp.svg",
      ),
      const ContactInfoWidget(
        imagePath: "assets/images/svg/linkedin.svg",
      ),

    ];
    return Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
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
                Padding(
                  padding:  EdgeInsets.only(top:screenHeight * 0.21 ),
                  child: const ProfileImageWidget(profileImage: 'assets/images/jpg/profile_image.jpg', viewsNumber: '55',),
                ),

                Positioned(
                  bottom: screenHeight*0.1,
                  right: 2,
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


              ],
            ),
            Text(
              "John Doe",
              style: AppFontStyles.boldH1.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomCard(title:"Experiences",operation: "Manage",jobs: jobs,onOperationPressed: (){ Navigator.of(context).pushNamed(AppRoutes.myExperiences);},),
            SizedBox(height: screenHeight*0.02,),
            CustomCard(title:"Skills",operation: "Manage",skills: skills,onOperationPressed: (){ Navigator.of(context).pushNamed(AppRoutes.mySkills);},),
            SizedBox(height: screenHeight*0.02,),
            CustomCard(title:"Education & Certificates",operation: "Manage",educationAndCertificates: educationAndCertificates),
            SizedBox(height: screenHeight*0.02,),
            CustomCard(title:"Contact Info",operation: "Manage",contactInfo: contacts),
          ],
        ),
      ),
    );
  }
}
