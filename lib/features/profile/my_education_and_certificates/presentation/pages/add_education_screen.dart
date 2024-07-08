import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/display_generation_screen.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../bloc/education_actions_bloc.dart';

class AddEducationScreen extends StatefulWidget {
  const AddEducationScreen({this.arguments, Key? key}) : super(key: key);
  final DisplayGenerationScreenArguments? arguments;
  @override
  State<AddEducationScreen> createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController universityController;
  late TextEditingController descriptionController;
  late TextEditingController gradeDateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    final arg = widget.arguments;
    if (arg != null) {
      final event = arg.event as PostEducationGenerationEvent;
      nameController = TextEditingController(text: event.specialization);
      universityController = TextEditingController(text: event.school);
      descriptionController = TextEditingController(text: arg.generation);
    } else {
      nameController = TextEditingController();
      universityController = TextEditingController();
      descriptionController = TextEditingController();
    }

    super.initState();
  }

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
          title:  Text(
            AppStrings.addEducation,
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
                label: AppStrings.specialization+AppStrings.star,
                onlyNumber: false,
                hintText: AppStrings.softwareEngineering,
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.specialization+AppStrings.isRequired;
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
                label: AppStrings.description,
                onlyNumber: false,
                hintText: AppStrings.describeEducation,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: gradeDateController,
                label: AppStrings.gradePercent,
                onlyNumber: true,
                textInputType: TextInputType.number,
                hintText: '81.2',
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: universityController,
                label: AppStrings.university,
                onlyNumber: false,
                hintText: AppStrings.damascusUniversity,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: linkController,
                label: AppStrings.certificateLink,
                onlyNumber: false,
                hintText: 'https://certificatelink.com',
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DatePickerWidget(
                label: AppStrings.startDate+AppStrings.star,
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
                label: AppStrings.endDate+AppStrings.star,
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
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.1),
          child: BlocBuilder<EducationActionsBloc, EducationActionsState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                title: AppStrings.add,
                isLoading: state is EducationActionsLoadingState,
                onPressed: () {
                  if (_key.currentState!.validate() &&
                      selectedStartDate != null &&
                      selectedEndDate != null) {
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
