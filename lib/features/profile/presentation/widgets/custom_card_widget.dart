import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/contact_info_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/education_and_certificates_widget.dart';
import 'skill_widget.dart';
import 'job_widget.dart';

class CustomCard extends StatelessWidget {
  final List<JobWidget>? jobs;
  final List<SkillWidget>? skills;
  final List<EducationAndCertificatesWidget>? educationAndCertificates;
  final List<ContactInfoWidget>? contactInfo;
  final String title;
  final String operation;

  const CustomCard({
    Key? key,
    this.jobs,
    this.skills,
    this.educationAndCertificates,
    this.contactInfo,
    required this.title,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppFontStyles.boldH6,
                  ),
                  Text(
                    operation,
                    style: AppFontStyles.boldH6.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              jobs != null
                  ? Column(
                      children: jobs!.map((job) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01),
                          child: JobWidget(
                            role: job.role,
                            startDate: job.startDate,
                            endDate: job.endDate,
                            company: job.company,
                            description: job.description,
                          ),
                        );
                      }).toList(),
                    )
                  : skills != null
                      ? Column(
                          children: skills!.map((skill) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01),
                              child: SkillWidget(
                                skillName: skill.skillName,
                                imagePath: skill.imagePath,
                                description: skill.description,
                              ),
                            );
                          }).toList(),
                        )
                      : educationAndCertificates != null
                          ? Column(
                              children: educationAndCertificates!
                                  .map((educationAndCertificates) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  child: EducationAndCertificatesWidget(
                                    specialization:
                                        educationAndCertificates.specialization,
                                    startDate:
                                        educationAndCertificates.startDate,
                                    endDate: educationAndCertificates.endDate,
                                    organization:
                                        educationAndCertificates.organization,
                                    description:
                                        educationAndCertificates.description,
                                  ),
                                );
                              }).toList(),
                            )
                          : contactInfo != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: contactInfo!
                                      .map((contactInfo) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01),
                                      child: ContactInfoWidget(
                                        imagePath: contactInfo.imagePath,
                                      ),
                                    );
                                  }).toList(),
                                )
                              : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
