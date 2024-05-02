import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../applicant_features/home/presentation/widgets/top_jobs_widget.dart';
import '../../../applicant_profile/presentation/widgets/contact_info_widget.dart';
import '../../../applicant_profile/presentation/widgets/custom_profile_card_widget.dart';
import '../../../applicant_profile/presentation/widgets/education_and_certificates_widget.dart';
import '../../../applicant_profile/presentation/widgets/experience_widget.dart';
import '../../../applicant_profile/presentation/widgets/profile_image_widget.dart';
import '../../../applicant_profile/presentation/widgets/skill_widget.dart';
import '../../../job_details/presentation/widgets/description_item_widget.dart';

class CompanyProfileScreen extends StatefulWidget {
  final bool visitor;
  const CompanyProfileScreen({
    Key? key,
    this.visitor = false,
  }) : super(key: key);

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
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
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan nibh non augue dignissim, quis fringilla nulla ullamcorper. Phasellus et augue eu nulla malesuada euismod.",
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
                  padding: EdgeInsets.only(top: screenHeight * 0.21),
                  child: ProfileImageWidget(
                    visitor: widget.visitor,
                    profileImage: Assets.jpgCompanyProfile,
                    viewsNumber: '55',
                  ),
                ),
                !widget.visitor
                    ? Positioned(
                        bottom: screenHeight * 0.08,
                        right: 4,
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
                      )
                    : const Text(""),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              "TechNex Company",
              style: AppFontStyles.boldH2.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const CustomCard(
                title: "Description",
                operation: "Manage",
                content: Text(
                  "TechNex Solutions is a leading software development company at the forefront of innovation, dedicated to empowering businesses with cutting-edge technological solutions. With a passion for excellence and a commitment to client satisfaction, we leverage the latest advancements in software development to drive digital transformation and fuel growth for our clients worldwide.",
                  style: AppFontStyles.mediumH4,
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const CustomCard(
                title: "Vision",
                operation: "Manage",
                content: Text(
                  "Our vision at TechNex Solutions is to redefine the boundaries of possibility through technology. We strive to be the catalysts of change, revolutionizing industries and empowering organizations to thrive in the digital age.",
                  style: AppFontStyles.mediumH4,
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const CustomCard(
                title: "Benefits",
                operation: "Manage",
                content: Column(
                  children: [
                    DescriptionItemWidget(
                        description:
                            "Employees are not allowed to use AI tools in the company."),
                    DescriptionItemWidget(
                        description:
                            "Employees are not allowed to share company's technologies or tools outside the company "),
                    DescriptionItemWidget(
                        description:
                            "All employees are expected to dress in a manner that is appropriate for their role and conducive to a professional work environment.",
                    ),
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            const CustomCard(
                title: "Policies",
                operation: "Manage",
                content: Column(
                  children: [
                    DescriptionItemWidget(
                        description:
                            "At TechNex Solutions, you'll be part of a dynamic and innovative work culture that encourages creativity, collaboration, and out-of-the-box thinking. You'll have the opportunity to work on cutting-edge projects and leverage the latest technologies to solve complex challenges."),
                    DescriptionItemWidget(
                        description:
                            "We are committed to the growth and development of our employees. As a member of our team, you'll have access to ongoing training, mentorship programs, and opportunities for advancement. Whether you're looking to enhance your technical skills, expand your knowledge, or take on new responsibilities, we'll support you every step of the way."),
                  ],
                )),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomProfileCard(
                title: "Contact Info",
                operation: widget.visitor ? "" : "Manage",
                contactInfo: contacts),
            const TopJobsSectionWidget(),
          ],
        ),
      ),
    );
  }
}
