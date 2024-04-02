
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/app_style.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/more/presentation/widgets/more_items_widget.dart';

import '../../../../generated/assets.dart';
import '../widgets/employee_on_road_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              const EmployeeOnRoad(),
              MoreItemsWidget(iconPath: Assets.svgMySubmissions, text: 'My Submissions', topPadding: screenHeight*0.55,),
              MoreItemsWidget(iconPath: Assets.svgNotification, text: 'Notifications', topPadding: screenHeight*0.65,),
              MoreItemsWidget(iconPath: Assets.svgLanguage, text: 'Language', topPadding: screenHeight*0.75,),
              MoreItemsWidget(iconPath: Assets.svgUpdate, text: 'Update', topPadding: screenHeight*0.85,),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MoreItemsWidget(iconPath: Assets.svgSignOut, text: 'SignOut', topPadding: screenHeight*0.95,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
