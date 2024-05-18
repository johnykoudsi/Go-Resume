import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/education.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/contact_info_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/education_and_certificates_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/experience_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/profile_image_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/skill_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';

class ApplicantProfileScreen extends StatefulWidget {
  const ApplicantProfileScreen({
    required this.user,
    Key? key,
    this.visitor = true,
  }) : super(key: key);

  final User user;
  final bool visitor;

  @override
  State<ApplicantProfileScreen> createState() => _ApplicantProfileScreenState();
}

class _ApplicantProfileScreenState extends State<ApplicantProfileScreen> {
  late User user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserBloc>().add(RefreshUserEvent());
        },
        child: ListView(
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
                    visitor: !widget.visitor,
                    profileImage: 'assets/images/jpg/profile_image.jpg',
                    viewsNumber: "0",
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
            Center(
              child: Text(
                user.fullName,
                style: AppFontStyles.boldH2.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                user.applicant?.bio ?? "",
                style: AppFontStyles.boldH4.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            CustomCard(
              title: "Experiences",
              visitor: widget.visitor,
              content: Column(
                children: List.generate(
                  user.applicant?.experiences?.length ?? 0,
                  (index) {
                    Experience? e = user.applicant?.experiences?[index];
                    return ExperienceWidget(
                      experience: e!,
                    );
                  },
                ),
              ),
              onOperationPressed: () {
                Navigator.pushNamed(context, AppRoutes.myExperiences,
                    arguments: user.applicant?.experiences);
              },
            ),
            const SizedBox(
              height: 18,
            ),
            CustomCard(
              title: "Skills",
              visitor: widget.visitor,
              content: Column(
                children: List.generate(
                  user.applicant?.skills?.length ?? 0,
                      (index) {
                    Skill? s = user.applicant?.skills?[index];
                    return SkillWidget(
                      skill: s!,
                    );
                  },
                ),
              ),
              onOperationPressed: () {
                Navigator.pushNamed(context, AppRoutes.mySkills,
                    arguments: user.applicant?.skills);
              },
            ),
            const SizedBox(
              height: 18,
            ),
            CustomCard(
              title: "Education & Certificates",
              visitor: widget.visitor,
              content: Column(
                children: List.generate(
                  user.applicant?.education?.length ?? 0,
                  (index) {
                    Education? e = user.applicant?.education?[index];
                    return EducationAndCertificatesWidget(
                      education: e!,
                    );
                  },
                ),
              ),
              onOperationPressed: () {
                Navigator.of(context).pushNamed(
                    AppRoutes.myEducationAndCertificates,
                    arguments: user.applicant?.education);
              },
            ),
            const SizedBox(
              height: 18,
            ),
            CustomCard(
              title: "Contact Info",
              visitor: widget.visitor,
              content: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContactInfoWidget(imagePath: Assets.svgFacebook),
                  ContactInfoWidget(imagePath: Assets.svgLinkedin),
                  ContactInfoWidget(imagePath: Assets.svgWhatsapp),
                  ContactInfoWidget(imagePath: Assets.svgPhone),
                  ContactInfoWidget(imagePath: Assets.svgTelegram),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
