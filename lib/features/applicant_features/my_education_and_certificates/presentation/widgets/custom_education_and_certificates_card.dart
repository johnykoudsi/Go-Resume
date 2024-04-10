import 'package:flutter/material.dart';

import '../../../../../utility/global_widgets/custom_card.dart';
import '../../../profile/presentation/widgets/education_and_certificates_widget.dart';

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
    return CustomCard(title: title, operation: operation, content: EducationAndCertificatesWidget(
      description: education_and_certificates.description,
      startDate: education_and_certificates.startDate,
      endDate: education_and_certificates.endDate,
      specialization:education_and_certificates.specialization,
      organization: education_and_certificates.organization,
    ),
    );
  }
}
