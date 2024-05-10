import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import 'contact_info_widget.dart';
import 'education_and_certificates_widget.dart';
import 'skill_widget.dart';
import 'experience_widget.dart';

class CustomProfileCard extends StatelessWidget {
  final List<Experience>? jobs;
  final List<SkillWidget>? skills;
  final List<EducationAndCertificatesWidget>? educationAndCertificates;
  final List<ContactInfoWidget>? contactInfo;
  final String title;
  final String operation;
  final VoidCallback? onOperationPressed;

  const CustomProfileCard({
    Key? key,
    this.jobs,
    this.skills,
    this.educationAndCertificates,
    this.contactInfo,
    required this.title,
    required this.operation,
    this.onOperationPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return CustomCard(
      onOperationPressed: onOperationPressed,
      title: title, operation: operation,
        content:              jobs != null
            ? Column(
          children: jobs!.map((job) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01),
              child: ExperienceWidget(
                role: job.title,
                startDate: job.startDate != null ? '${job.startDate!.day}/${job.startDate!.month}/${job.startDate!.year}':"",
                endDate: job.endDate != null ?'${job.endDate!.day}/${job.endDate!.month}/${job.endDate!.year}':"present",
                company: job.company??"",
                description: job.description??"",
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

    );
  }
}
