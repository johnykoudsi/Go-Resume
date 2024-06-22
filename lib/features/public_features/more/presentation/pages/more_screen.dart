import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/utility/app_strings.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../generated/assets.dart';
import '../../../../../utility/dialog/language_dialog.dart';
import '../widgets/employee_on_road_widget.dart';
import '../widgets/more_items_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late User user;
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: ListView(
        children: [
          const EmployeeOnRoad(),
          Column(
            children: [
              MoreItemsWidget(
                iconPath: Assets.svgMySubmissions,
                text: user.company == null
                    ? AppStrings.mySubmissions
                    : AppStrings.myJobs,
                topPadding: screenHeight * 0.55,
                onTap: user.company == null
                    ? () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.mySubmissions);
                }
                    : () {
                  Navigator.of(context).pushNamed(AppRoutes.myJobs,
                      arguments: user = user);
                },
              ),
              MoreItemsWidget(
                  iconPath: Assets.svgSave,
                  text: AppStrings.savedJobs,
                  topPadding: screenHeight * 0.65,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.savedJobs);
                  }),
              MoreItemsWidget(
                  iconPath: Assets.svgNotification,
                  text: AppStrings.notifications,
                  topPadding: screenHeight * 0.75,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.myNotifications);
                  }),
              MoreItemsWidget(
                iconPath: Assets.svgLanguage,
                text: AppStrings.language,
                topPadding: screenHeight * 0.85,
                onTap: () {
                  LanguageDialog.showLanguageBottomSheet(context);
                },
              ),
              MoreItemsWidget(
                iconPath: Assets.svgUpdate,
                text: AppStrings.update,
                topPadding: screenHeight * 0.95,
              ),
              GestureDetector(
                onTap: () {
                  DialogsWidgetsYesNo.showYesNoDialog(
                      title: AppStrings.signOutQuestion,
                      noTitle: AppStrings.cancel,
                      yesTitle: AppStrings.signOut,
                      onYesTap: () {
                        context.read<UserBloc>().add(LogoutEvent());
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.login,
                                (Route<dynamic> route) => false);
                      },
                      onNoTap: () {
                        Navigator.of(context).pop();
                      },
                      context: context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: MoreItemsWidget(
                    iconPath: Assets.svgSignOut,
                    text: AppStrings.signOut,
                    topPadding: screenHeight * 1.05,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
