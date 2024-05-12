import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';

import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/description_field.dart';

import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../bloc/education_actions_bloc.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({Key? key}) : super(key: key);

  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController gradeDateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
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
            popOnSuccessCount: 2,
          );
          context.read<UserBloc>().add(RefreshUserEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Education",
            style: AppFontStyles.boldH3,
          ),
        ),
        body: Form(
          key: _key,
          child: ListView(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Specialization is required";
                  }
                  return null;
                },
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
                onlyNumber: true,
                textInputType: TextInputType.number,
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
                label: 'Start Date*',
                selectedDate: selectedStartDate,
                onDateChange: (date) {
                  setState(() {
                    selectedStartDate = date;
                  });
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DatePickerWidget(
                label: 'End Date*',
                selectedDate: selectedEndDate,
                onDateChange: (date) {
                  setState(() {
                    selectedEndDate = date;
                  });
                },
              ),
              SizedBox(
                height: heightBetweenFields * 5,
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.1),
          child: BlocBuilder<EducationActionsBloc, EducationActionsState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                title: "Add",
                isLoading: state is EducationActionsLoadingState,
                onPressed: () {
                  if (_key.currentState!.validate() &&
                      selectedStartDate != null &&
                      selectedEndDate!= null) {
                    FocusScope.of(context).unfocus();
                    context.read<EducationActionsBloc>().add(AddEducationEvent(
                        description: descriptionController.text,
                        startDate: selectedStartDate.toString(),
                        endDate: selectedEndDate.toString(),
                        name: nameController.text,
                        university: universityController.text,
                        grade: gradeDateController.text,
                        link: linkController.text));
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
