import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';

import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/date_picker_widget.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../recruiter_features/add_job/presentation/widgets/description_field.dart';
import '../../../../recruiter_features/add_job/presentation/widgets/preferred_gender_widget.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({Key? key}) : super(key: key);

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  TextEditingController positionController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  int workFieldId = 0;
  bool currentlyIn = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return BlocListener<ExperienceActionsBloc, ExperienceActionsState>(
      listener: (context, state) {
        if (state is ExperienceActionsResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
              context: context,
              helperResponse: state.helperResponse,
              popOnSuccess: true,
              popOnSuccessCount: 2,
          );
          context.read<UserBloc>().add(RefreshUserEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Experience",
            style: AppFontStyles.boldH2,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.03),
          children: [
            CustomTextField(
              action: TextInputAction.done,
              controller: positionController,
              label: "Position*",
              onlyNumber: false,
              hintText: 'Example: Assistant Manager',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: descriptionController,
              label: "Description",
              onlyNumber: false,
              hintText: 'Describe your work with a few words',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DatePickerWidget(
                label: 'Start Date*', controller: startDateController),
            SizedBox(
              height: heightBetweenFields,
            ),
            DatePickerWidget(label: 'End Date*', controller: endDateController),
            SizedBox(
              height: heightBetweenFields * 5,
            ),
            BlocBuilder<ExperienceActionsBloc, ExperienceActionsState>(
              builder: (context, state) {
                return ElevatedButtonWidget(
                  title: "Add",
                  isLoading: state is ExperienceActionsLoadingState,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.read<ExperienceActionsBloc>().add(
                        AddExperienceEvent(
                            position: positionController.text,
                            description: descriptionController.text,
                            startDate: startDateController.text,
                            endDate: endDateController.text,
                            workField: '1',
                            company: companyController.text));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
