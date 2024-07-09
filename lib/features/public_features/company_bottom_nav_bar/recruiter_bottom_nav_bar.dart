import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/applicant_bottom_nav_bar/widgets/CustomNavigatorWidget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../../../utility/app_strings.dart';
import 'widgets/recruiter_bottom_nav_bar_screens.dart';

class RecruiterBottomNavBar extends StatefulWidget {
  const RecruiterBottomNavBar({Key? key}) : super(key: key);

  @override
  State<RecruiterBottomNavBar> createState() => _RecruiterBottomNavBarState();
}

class _RecruiterBottomNavBarState extends State<RecruiterBottomNavBar> {
  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;
  int selectedIndex = 0;
  bool isReverse = false;

  @override
  Widget build(BuildContext context) {
    double getWidth = MediaQuery.of(context).size.width;
    double getHeight = MediaQuery.of(context).size.height;
    Future<bool> onWillPopMethod() async {
      return DialogsWidgetsYesNo.onWillPopMethod(context);
    }

    return ColoredBox(
      color: AppColors.kBackGroundColor,
      child: SafeArea(
        bottom: false,
        child: WillPopScope(
          onWillPop: onWillPopMethod,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: SizedBox(
              height: getWidth * 0.22,
              child: BottomNavigationBar(
                selectedFontSize: 0.0,
                unselectedFontSize: 0.0,
                elevation: 0,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: onItemTapped,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 0,
                      svgPath: Assets.svgCase,
                      selectedIndex: selectedIndex,
                    ),
                    label: "myJobs".tr(),
                    tooltip: "myJobs".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 1,
                      svgPath: Assets.svgPin,
                      selectedIndex: selectedIndex,
                    ),
                    label: "pinned".tr(),
                    tooltip: "pinned".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 2,
                      svgPath: Assets.svgProfile,
                      selectedIndex: selectedIndex,
                    ),
                    label: "profile".tr(),
                    tooltip: "profile".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 3,
                      svgPath: Assets.svgAdd,
                      selectedIndex: selectedIndex,
                    ),
                    label: "add".tr(),
                    tooltip: "add".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 4,
                      svgPath: Assets.svgMore,
                      selectedIndex: selectedIndex,
                    ),
                    label: "more".tr(),
                    tooltip: "more".tr(),
                  ),
                ],
              ),
            ),
            body: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 600),
              reverse:
                  context.locale.languageCode == 'ar' ? !isReverse : isReverse,
              transitionBuilder: (Widget child, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: _transitionType,
                  child: child,
                );
              },
              child: GetSelectedRecruiterScreenByIndex(
                screenIndex: selectedIndex,
                key: Key(selectedIndex.toString()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      if (index > selectedIndex) {
        isReverse = false;
      } else {
        isReverse = true;
      }
      selectedIndex = index;
    });
  }
}
