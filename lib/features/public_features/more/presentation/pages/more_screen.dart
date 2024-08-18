import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../../generated/assets.dart';
import '../../../../../utility/dialog/language_dialog.dart';
import '../../../../../utility/global_widgets/dialogs_yes_no.dart';
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
                    ? "mySubmissions".tr()
                    : "myJobs".tr(),
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
              if (user.company == null)
                MoreItemsWidget(
                    iconPath: Assets.svgSave,
                    text: "savedJobs".tr(),
                    topPadding: screenHeight * 0.65,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.savedJobs);
                    }),
              MoreItemsWidget(
                  iconPath: Assets.svgNotification,
                  text: "notifications".tr(),
                  topPadding: screenHeight * 0.75,
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.myNotifications);
                  }),
              MoreItemsWidget(
                iconPath: Assets.svgLanguage,
                text: "language".tr(),
                topPadding: screenHeight * 0.85,
                onTap: () {
                  setState(() {

                    LanguageDialog.showLanguageBottomSheet(context);

                  });
                },
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).restorablePush(_modalBuilder);
                },
                child: MoreItemsWidget(
                  iconPath: Assets.svgUpdate,
                  text: "update".tr(),
                  topPadding: screenHeight * 0.95,
                ),
              ),
              GestureDetector(
                onTap: () {
                  DialogsWidgetsYesNo.showYesNoDialog(
                      title: "signOutQuestion".tr(),
                      noTitle: "cancel".tr(),
                      yesTitle: "signOut".tr(),
                      onYesTap: () {
                        context.read<UserBloc>().add(LogoutEvent());
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.login, (Route<dynamic> route) => false);
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
                    text: "signOut".tr(),
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
  @pragma('vm:entry-point')
  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('checkUpdates'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text('noUpdates',style: AppFontStyles.mediumH3,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
