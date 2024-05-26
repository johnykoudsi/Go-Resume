
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

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
    return  Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              const EmployeeOnRoad(),

               MoreItemsWidget(iconPath: Assets.svgMySubmissions, text:user.company == null ? 'My Submissions'.tr():"My Jobs".tr(), topPadding: screenHeight*0.55,onTap:user.company == null ? (){Navigator.of(context).pushNamed(AppRoutes.mySubmissions);}:(){Navigator.of(context).pushNamed(AppRoutes.mySubmissions);},),


              MoreItemsWidget(iconPath: Assets.svgNotification, text: 'Notifications'.tr(), topPadding: screenHeight*0.65,onTap: (){Navigator.of(context).pushNamed(AppRoutes.myNotifications);}),
              MoreItemsWidget(iconPath: Assets.svgLanguage, text: 'Language'.tr(), topPadding: screenHeight*0.75,   onTap: () {
                LanguageDialog.showLanguageBottomSheet(context);
              },),
              MoreItemsWidget(iconPath: Assets.svgUpdate, text: 'Update'.tr(), topPadding: screenHeight*0.85,),
              GestureDetector(
                onTap: () {
                  DialogsWidgetsYesNo.showYesNoDialog(
                      title: "Are you sure you want to sign out?".tr(),
                      noTitle: "Cancel".tr(),
                      yesTitle: "Sign out",
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
                  child: MoreItemsWidget(iconPath: Assets.svgSignOut, text: 'Sign out'.tr(), topPadding: screenHeight*0.95,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
