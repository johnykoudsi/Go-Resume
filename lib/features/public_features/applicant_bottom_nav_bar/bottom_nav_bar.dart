import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../../../utility/app_strings.dart';
import 'widgets/CustomNavigatorWidget.dart';
import 'widgets/bottom_nav_bar_screens.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
                      svgPath: Assets.svgHome,
                      selectedIndex: selectedIndex,
                    ),
                    label: "home".tr(),
                    tooltip: "home".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: CustomNavigatorWidget(
                      widgetIndex: 1,
                      svgPath: Assets.svgCase,
                      selectedIndex: selectedIndex,
                    ),
                    label: "jobs".tr(),
                    tooltip:"jobs".tr(),
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
                      svgPath: Assets.svgStar,
                      selectedIndex: selectedIndex,
                    ),
                    label: "favorite".tr(),
                    tooltip: "favorite".tr(),
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
              child: GetSelectedScreenByIndex(
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
