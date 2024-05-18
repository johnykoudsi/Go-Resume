import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';

import '../widgets/job_widget.dart';

class AllJobsScreen extends StatefulWidget {
  const AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs".tr()),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myNotifications);
              }, icon: SvgPicture.asset(Assets.svgNotification))
        ],
        bottom:PreferredSize(
          preferredSize: const Size(double.infinity,75),
          child: SearchTextField(
            onClear: () {},
            onSend: (value) {},
            searchController: searchController,
            showSearchDeleteIcon: false,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // JobWidget(),
          // JobWidget(),
          // JobWidget(),
          // JobWidget(),
          // JobWidget(),
        ],
      ),
    );
  }
}
