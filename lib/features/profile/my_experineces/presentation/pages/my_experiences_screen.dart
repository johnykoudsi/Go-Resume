import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/shimmer.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/experience_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_actions_bloc/experience_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';

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
    return BlocListener<ExperienceActionsBloc, ExperienceActionsState>(
      listener: (context, state) {
        if (state is ExperienceActionsResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: true,
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
            "myExperiences".tr(),
            style: AppFontStyles.boldH3,
          ),
          iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
        ),
        body: widget.experiences.isEmpty
            ? const NoDataWidget()
            : ListView.builder(
                itemCount: widget.experiences.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: BlocBuilder<ExperienceActionsBloc,
                        ExperienceActionsState>(
                      builder: (context, state) {
                        if (state is ExperienceActionsLoadingState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: AppShimmerLoader(),
                          );
                        }
                        return CustomCard(
                          onOperationPressed: () {
                            DialogsWidgetsYesNo.showYesNoDialog(
                              title:
                                  "areYouSureToDelete".tr(),
                              noTitle: "no".tr(),
                              yesTitle: "yes".tr(),
                              isLoading: state is ExperienceActionsLoadingState,
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
                          operation: "delete".tr(),
                          title: "experience".tr(),
                          content: ExperienceWidget(
                            experience: widget.experiences[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomFloatingButtonWidget(
              icon: const Icon(Icons.auto_fix_high_rounded),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.experienceAIGeneration);
              },
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            CustomFloatingButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addExperience);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
