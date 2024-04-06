import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/education_and_certificates_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/presentation/widgets/experience_widget.dart';

class CustomEducationAndCertificatesCard extends StatelessWidget {
  const CustomEducationAndCertificatesCard(
      {Key? key,
        required this.title,
        required this.operation,
        required this.education_and_certificates,
        this.onOperationPressed})
      : super(key: key);
  final String title;
  final String operation;
  final EducationAndCertificatesWidget education_and_certificates;
  final VoidCallback? onOperationPressed;
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
                  GestureDetector(
                    onTap: () {
                      onOperationPressed;
                    },
                    child: Text(
                      operation,
                      style: AppFontStyles.boldH6.copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: EducationAndCertificatesWidget(
                      description: education_and_certificates.description,
                      startDate: education_and_certificates.startDate,
                      endDate: education_and_certificates.endDate,
                    specialization:education_and_certificates.specialization,
                    organization: education_and_certificates.organization,

                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
