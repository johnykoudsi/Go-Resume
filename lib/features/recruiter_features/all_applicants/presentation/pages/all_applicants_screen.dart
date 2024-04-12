import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../generated/assets.dart';
import '../../../../../utility/global_widgets/search_text_field.dart';
import '../../../../shared_features/job_details/presentation/widgets/job_applicants_widget.dart';

class AllApplicantsScreen extends StatefulWidget {
  const AllApplicantsScreen({Key? key}) : super(key: key);

  @override
  State<AllApplicantsScreen> createState() => _AllApplicantsScreenState();
}

class _AllApplicantsScreenState extends State<AllApplicantsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 75),
          child: SearchTextField(
            onClear: () {},
            onSend: (value) {},
            searchController: searchController,
            showSearchDeleteIcon: false,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myNotifications);
              },
              icon: SvgPicture.asset(
                Assets.svgNotification,
              ))
        ],
        toolbarHeight: screenHeight * 0.15,
        title: const Text(
          "Applicants For Software Engineer",
          style: AppFontStyles.boldH2,
          maxLines: 2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: const [
            JobApplicantsWidget(canReject: true,),
            JobApplicantsWidget(canReject: true,),
            JobApplicantsWidget(canReject: true,),
            JobApplicantsWidget(canReject: true,),
          ],
        ),
      ),
    );
  }
}
