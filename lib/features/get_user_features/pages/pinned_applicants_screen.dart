import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_applicants_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';


class PinnedApplicantsScreen extends StatefulWidget {
  const PinnedApplicantsScreen({super.key});

  @override
  State<PinnedApplicantsScreen> createState() => _PinnedApplicantsScreenState();
}

class _PinnedApplicantsScreenState extends State<PinnedApplicantsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pinned Applicants".tr(),style: AppFontStyles.boldH3,),
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
        children: const [
          JobApplicantsWidget(),
          JobApplicantsWidget(),
          JobApplicantsWidget(),
          JobApplicantsWidget(),

        ],
      ),
    );
  }
}
