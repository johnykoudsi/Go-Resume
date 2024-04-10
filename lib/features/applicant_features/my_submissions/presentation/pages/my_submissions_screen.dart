import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../../all_jobs/presentation/widgtes/job_widget.dart';

class MySubmissionsScreen extends StatefulWidget {
  const MySubmissionsScreen({Key? key}) : super(key: key);

  @override
  State<MySubmissionsScreen> createState() => _MySubmissionsScreenState();
}


class _MySubmissionsScreenState extends State<MySubmissionsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Submissions",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          JobWidget(),
          JobWidget(),
          JobWidget(),
          JobWidget(),
          JobWidget(),
        ],
      ),

    );
  }
}
