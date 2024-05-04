import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../shared_features/applicant_profile/presentation/widgets/education_and_certificates_widget.dart';
import '../widgets/custom_education_and_certificates_card.dart';


class MyEducationAndCertificatesScreen extends StatefulWidget {
  const MyEducationAndCertificatesScreen({Key? key}) : super(key: key);

  @override
  State<MyEducationAndCertificatesScreen> createState() =>
      _MyEducationAndCertificatesScreenState();
}

List<EducationAndCertificatesWidget> education_and_certificates = [
  const EducationAndCertificatesWidget(
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam accumsan nibh non augue dignissim, quis fringilla nulla ullamcorper. Phasellus et augue eu nulla malesuada euismod.",
    startDate: '5/2008',
    endDate: '6/2009',
    specialization: 'Networking',
    organization: 'Damascus University',
  ),
];

class _MyEducationAndCertificatesScreenState
    extends State<MyEducationAndCertificatesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Education & Certificates",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: education_and_certificates.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: CustomEducationAndCertificatesCard(
              title: "Education & Certificates",
              operation: "Delete",
              education_and_certificates: education_and_certificates[index],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const CustomFloatingButtonWidget(
            title: "AI",
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          const CustomFloatingButtonWidget(
            title: "New",
          ),
        ],
      ),
    );
  }
}