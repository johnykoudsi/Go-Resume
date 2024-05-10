import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/date_picker_widget.dart';

import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../recruiter_features/add_job/presentation/widgets/description_field.dart';
import '../bloc/education_actions_bloc.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController gradeDateController = TextEditingController();
  TextEditingController linkController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return BlocListener<EducationActionsBloc, EducationActionsState>(
      listener: (context, state) {
        if (state is EducationActionsResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: true,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Education",
            style: AppFontStyles.boldH2,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.03),
          children: [
            CustomTextField(
              action: TextInputAction.done,
              controller: nameController,
              label: "Specialization*",
              onlyNumber: false,
              hintText: 'Example: Software Engineering',
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
              hintText: 'Describe your education with a few words',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: gradeDateController,
              label: "Grade Percent",
              onlyNumber: false,
              hintText: 'Example: 81.2',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: universityController,
              label: "University",
              onlyNumber: false,
              hintText: 'Example: Damascus University',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: linkController,
              label: "Certificate Link",
              onlyNumber: false,
              hintText: 'https://certificatelink.com',
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

            BlocBuilder<EducationActionsBloc, EducationActionsState>(
              builder: (context, state) {
                return ElevatedButtonWidget(
                  title: "Add",
                  isLoading: state is EducationActionsLoadingState,
                  onPressed: () {
                    context.read<EducationActionsBloc>().add(AddEducationEvent(
                        description: descriptionController.text,
                        startDate: startDateController.text,
                        endDate: endDateController.text,
                        name: nameController.text,
                        university: universityController.text,
                        grade: gradeDateController.text,
                        link: linkController.text
                    ));
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