import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
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
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/display_generation_screen.dart';

import '../../../../../utility/app_strings.dart';

class ExperienceGenerationScreen extends StatefulWidget {
  const ExperienceGenerationScreen({super.key});

  @override
  State<ExperienceGenerationScreen> createState() =>
      _ExperienceGenerationScreenState();
}

class _ExperienceGenerationScreenState
    extends State<ExperienceGenerationScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController specializationTextController = TextEditingController();
  TextEditingController companyTextController = TextEditingController();
  TextEditingController numberOfYearsController = TextEditingController();
  TextEditingController numberOfMonthsController = TextEditingController();
  TextEditingController additionalKeyWordsController = TextEditingController();
  late PostExperienceGenerationEvent postExperienceGeneration;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;

    return BlocProvider(
      create: (context) => ExperienceGenerationBloc(),
      child: BlocListener<ExperienceGenerationBloc, ExperienceGenerationState>(
        listener: (context, state) {
          if (state is ExperienceGenerationDoneState) {
            Navigator.of(context).pushNamed(AppRoutes.displayGenerationScreen,
                arguments: DisplayGenerationScreenArguments(
                    event: postExperienceGeneration,
                    generation: state.generation));
          }
          if (state is ExperienceGenerationErrorState) {
            DialogsWidgetsSnackBar.showSnackBarFromStatus(
              context: context,
              helperResponse: state.response,
              popOnSuccess: false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title:  Text(
              "generateExperience".tr(),
              style: AppFontStyles.boldH3,
            ),
          ),
          body:
              BlocBuilder<ExperienceGenerationBloc, ExperienceGenerationState>(
            builder: (context, state) {
              if (state is ExperienceGenerationLoadingState) {
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
                              "gatheringYourInfo".tr(),
                              textStyle: AppFontStyles.boldH3,
                            ),
                            RotateAnimatedText(
                             "generatingExperience".tr(),
                              textStyle: AppFontStyles.boldH3,
                            ),
                            RotateAnimatedText(
                              "connectingToAI".tr(),
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
                      label: "specialization".tr(),
                      hintText: "softwareEngineering".tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "specialization".tr()+"isRequired".tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    CustomTextField(
                      action: TextInputAction.done,
                      controller: companyTextController,
                      label: "company".tr(),
                      hintText: "eWorld",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "company".tr()+"isRequired".tr();
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
                      label: "additionalKeyWords".tr(),
                      hintText: "agile scrum github",
                    ),
                    SizedBox(
                      height: heightBetweenFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            action: TextInputAction.done,
                            controller: numberOfYearsController,
                            textInputType: TextInputType.number,
                            label: "experienceYears".tr(),
                            hintText: "6",
                            onlyNumber: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "experienceYears".tr()+"isRequired".tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CustomTextField(
                            action: TextInputAction.done,
                            controller: numberOfMonthsController,
                            textInputType: TextInputType.number,
                            label: "experienceMonths".tr(),
                            hintText: "10",
                            onlyNumber: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
                screenWidth * 0.04, screenWidth * 0.1),
            child: BlocBuilder<ExperienceGenerationBloc,
                ExperienceGenerationState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is! ExperienceGenerationLoadingState)
                      ElevatedButtonWidget(
                        title: "generate".tr(),
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
                          postExperienceGeneration =
                              PostExperienceGenerationEvent(
                            company: companyTextController.text,
                            month: numberOfMonthsController.text,
                            specialization: specializationTextController.text,
                            years: numberOfYearsController.text,
                            skills: cleanedSkills,
                          );
                          context
                              .read<ExperienceGenerationBloc>()
                              .add(postExperienceGeneration);
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
