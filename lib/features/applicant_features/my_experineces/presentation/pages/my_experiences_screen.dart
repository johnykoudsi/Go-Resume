import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_education_and_certificates/presentation/bloc/education_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';

import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../shared_features/applicant_profile/presentation/widgets/experience_widget.dart';

class MyExperiencesScreen extends StatefulWidget {
  const MyExperiencesScreen({required this.experiences, Key? key})
      : super(key: key);
  final List<Experience> experiences;
  @override
  State<MyExperiencesScreen> createState() => _MyExperiencesScreenState();
}

class _MyExperiencesScreenState extends State<MyExperiencesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Experiences",
          style: AppFontStyles.boldH3,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView.builder(
        itemCount: widget.experiences.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: BlocConsumer<ExperienceActionsBloc, ExperienceActionsState>(
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
                            .read<ExperienceActionsBloc>()
                            .add(DeleteExperienceEvent(
                              id: widget.experiences[index].id,
                            ));
                      },
                      onNoTap: () {
                        Navigator.of(context).pop();
                      },
                      context: context,
                    );
                  },
                  operation: "Delete",
                  title: "Experience",
                  content: Column(
                    children: [
                      ExperienceWidget(
                        experience: widget.experiences[index],
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {
                if (state is ExperienceActionsErrorState) {
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
              Navigator.pushNamed(context, AppRoutes.addExperience);
            },
            title: "New",
          ),
        ],
      ),
    );
  }
}
