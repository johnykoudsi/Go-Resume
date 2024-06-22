import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_snackBar.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/display_generation_screen.dart';

class EducationGenerationScreen extends StatefulWidget {
  const EducationGenerationScreen({super.key});

  @override
  State<EducationGenerationScreen> createState() =>
      _EducationGenerationScreenState();
}

class _EducationGenerationScreenState extends State<EducationGenerationScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController specializationTextController = TextEditingController();
  TextEditingController schoolTextController = TextEditingController();
  TextEditingController additionalKeyWordsController = TextEditingController();
  TextEditingController graduationYearsController = TextEditingController();
  TextEditingController locationTextController = TextEditingController();
  late PostEducationGenerationEvent postEducationGeneration;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;

    return BlocProvider(
      create: (context) => EducationGenerationBloc(),
      child: BlocListener<EducationGenerationBloc, EducationGenerationState>(
        listener: (context, state) {
          if (state is EducationGenerationDoneState) {
            Navigator.of(context).pushNamed(AppRoutes.displayGenerationScreen,
                arguments: DisplayGenerationScreenArguments(
                    event: postEducationGeneration,
                    generation: state.generation));
          }
          if (state is EducationGenerationErrorState) {
            DialogsWidgetsSnackBar.showSnackBarFromStatus(
              context: context,
              helperResponse: state.response,
              popOnSuccess: false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Generate Education",
              style: AppFontStyles.boldH3,
            ),
          ),
          body: BlocBuilder<EducationGenerationBloc, EducationGenerationState>(
            builder: (context, state) {
              if (state is EducationGenerationLoadingState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(Assets.jsonTextGeneration,
                          repeat: true, height: screenHeight * 0.5),
                      SizedBox(
                        height: 100,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText(
                              "Gathering your information!",
                              textStyle: AppFontStyles.boldH3,
                            ),
                            RotateAnimatedText(
                              "Generating Education description",
                              textStyle: AppFontStyles.boldH3,
                            ),
                            RotateAnimatedText(
                              "Connecting to the AI",
                              textStyle: AppFontStyles.boldH3,
                            ),
                          ],
                          repeatForever: true,
                          displayFullTextOnTap: false,
                          // stopPauseOnTap: true,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Form(
                key: _key,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.04,
                      screenWidth * 0.06,
                      screenWidth * 0.04,
                      screenWidth * 0.03),
                  children: [
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: specializationTextController,
                      label: "Specialization",
                      hintText: 'Example: Software Engineering',
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
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: schoolTextController,
                      label: "University",
                      hintText: "Damascus university",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "University is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: additionalKeyWordsController,
                      label: "Additional key words",
                      hintText: "agile scrum github",
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: locationTextController,
                      label: "Location",
                      hintText: "damascus - syria",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "location is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: graduationYearsController,
                      textInputType: TextInputType.number,
                      label: "Graduation Year",
                      hintText: "2025",
                      onlyNumber: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Graduation year is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
                screenWidth * 0.04, screenWidth * 0.1),
            child:
                BlocBuilder<EducationGenerationBloc, EducationGenerationState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is! EducationGenerationLoadingState)
                      ElevatedButtonWidget(
                        title: "Generate",
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!_key.currentState!.validate()) {
                            return;
                          }
                          final userState = context.read<UserBloc>().state;
                          if (userState is! UserLoggedState) {
                            return;
                          }
                          List<Skill> userSkills =
                              userState.user.data.applicant?.skills ?? [];

                          String skills = userSkills
                                  .map((skill) => skill.name.toString())
                                  .join(', ') +
                              additionalKeyWordsController.text;
                          RegExp punctuationRegExp = RegExp(r'[^\w\s]');

                          String cleanedSkills =
                              skills.replaceAll(punctuationRegExp, '');

                          postEducationGeneration =
                              PostEducationGenerationEvent(
                            specialization: specializationTextController.text,
                            skills: cleanedSkills,
                            school: schoolTextController.text,
                            graduationYears: graduationYearsController.text,
                            location: locationTextController.text,
                          );

                          context
                              .read<EducationGenerationBloc>()
                              .add(postEducationGeneration);
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
