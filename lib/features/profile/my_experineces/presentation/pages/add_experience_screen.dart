import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_snackBar.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/widgets/custom_check_box.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/display_generation_screen.dart';

import '../../../../../utility/app_strings.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({this.arguments, Key? key}) : super(key: key);
  final DisplayGenerationScreenArguments? arguments;
  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController positionController;
  late TextEditingController companyController;
  late TextEditingController descriptionController;
  int workFieldId = 0;
  bool _currentlyIn = false;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    final arg = widget.arguments;
    if (arg != null) {
      final event = arg.event as PostExperienceGenerationEvent;
      positionController =
          TextEditingController(text: event.specialization);
      companyController = TextEditingController(text: event.company);
      descriptionController = TextEditingController(text: arg.generation);
    } else {
      positionController = TextEditingController();
      companyController = TextEditingController();
      descriptionController = TextEditingController();
    }

    super.initState();
  }

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
          if (state.helperResponse.servicesResponse ==
              ServicesResponseStatues.success) {
            context.read<UserBloc>().add(RefreshUserEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            "addExperience".tr(),
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
                controller: positionController,
                label: "position".tr()+"star".tr(),
                onlyNumber: false,
                hintText: "assistantManager".tr(),
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "position".tr()+"isRequired".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: companyController,
                label: "company".tr(),
                onlyNumber: false,
                hintText: 'eWorld',
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DescriptionField(
                action: TextInputAction.done,
                controller: descriptionController,
                label: "description".tr(),
                onlyNumber: false,
                hintText: "describeYourWork".tr(),

              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DatePickerWidget(
                label: "startDate".tr()+"star".tr(),
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
              if (!_currentlyIn)
                DatePickerWidget(
                  label: "endDate".tr()+"star".tr(),
                  selectedDate: selectedEndDate,
                  onDateChange: (date) {
                    setState(() {
                      selectedEndDate = date;
                    });
                  },
                ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomCheckBox(
                text: "currentlyIn".tr(),
                isChecked: _currentlyIn,
                onChanged: (value) {
                  setState(() {
                    _currentlyIn = value;
                  });
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.1),
          child: BlocBuilder<ExperienceActionsBloc, ExperienceActionsState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                title: "add".tr(),
                isLoading: state is ExperienceActionsLoadingState,
                onPressed: () {
                  if (_currentlyIn || selectedEndDate != null) {
                    if (_key.currentState!.validate() &&
                        selectedStartDate != null) {
                      FocusScope.of(context).unfocus();
                      context.read<ExperienceActionsBloc>().add(
                          AddExperienceEvent(
                              currentlyIn:
                                  _currentlyIn.toString() == "true" ? "1" : "0",
                              position: positionController.text,
                              description: descriptionController.text,
                              startDate: selectedStartDate.toString(),
                              endDate: selectedEndDate.toString(),
                              workField: '1',
                              company: companyController.text));
                    }
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
