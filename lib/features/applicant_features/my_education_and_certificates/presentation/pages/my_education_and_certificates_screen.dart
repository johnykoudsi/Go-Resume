import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/education.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_education_and_certificates/presentation/bloc/education_actions_bloc.dart';

import '../../../../../utility/global_widgets/custom_card.dart';
import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../shared_features/applicant_profile/presentation/widgets/education_and_certificates_widget.dart';
import '../../../../shared_features/applicant_profile/presentation/widgets/experience_widget.dart';
import '../widgets/custom_education_and_certificates_card.dart';

class MyEducationAndCertificatesScreen extends StatefulWidget {
  const MyEducationAndCertificatesScreen({Key? key, required this.educations})
      : super(key: key);
  final List<Education> educations;

  @override
  State<MyEducationAndCertificatesScreen> createState() =>
      _MyEducationAndCertificatesScreenState();
}

class _MyEducationAndCertificatesScreenState
    extends State<MyEducationAndCertificatesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Education & Certificates",
          style: AppFontStyles.boldH3,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: widget.educations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: BlocConsumer<EducationActionsBloc, EducationActionsState>(
              builder: (context, state) {
                return CustomCard(
                  onOperationPressed: () {
                    DialogsWidgetsYesNo.showYesNoDialog(
                      title: "Are you sure you want to delete this item.",
                      noTitle: "No",
                      yesTitle: "Yes",
                      onYesTap: () {
                        Navigator.of(context).pop();
                        context
                            .read<EducationActionsBloc>()
                            .add(DeleteEducationEvent(
                              id: widget.educations[index].id,
                            ));
                      },
                      onNoTap: () {
                        Navigator.of(context).pop();
                      },
                      context: context,
                    );
                  },
                  operation: "Delete",
                  title: "Education",
                  content: Column(
                    children: [
                      EducationAndCertificatesWidget(
                          education: widget.educations[index]),
                    ],
                  ),
                );
              },
              listener: (context, state) {
                if (state is EducationActionsResponseState) {
                  DialogsWidgetsSnackBar.showSnackBarFromStatus(
                    context: context,
                    helperResponse: state.helperResponse,
                    popOnSuccess: true,
                  );
                }
              },
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
          CustomFloatingButtonWidget(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addEducation);
            },
            title: "New",
          ),
        ],
      ),
    );
  }
}
