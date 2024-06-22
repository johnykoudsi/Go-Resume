import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/jobs_horizantal_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';

import '../../../../../core/router/app_routes.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/home_companies_widget.dart';
import '../widgets/top_jobs_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Home",
        //   style: Theme.of(context)
        //       .appBarTheme
        //       .titleTextStyle!
        //       .copyWith(color: Colors.white),
        // ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myNotifications);
              },
              icon: SvgPicture.asset(
                Assets.svgNotification,
                color: Colors.white,
              ))
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 75),
          child: GestureDetector(
            onTap: () {
              // todo navigate to job screen
            },
            child: SearchTextField(
              enabled: false,
              searchController: searchController,
              showSearchDeleteIcon: false,
              onClear: () {},
              onSend: (val) {},
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.kLinearWideColor),
        ),
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 30,
          ),
          CarouselSliderWidget(),
          SizedBox(
            height: 30,
          ),
          TopJobsSectionWidget(),
          JobsHorizontalWidget(),
          SizedBox(
            height: 12,
          ),
          HomeCompaniesSectionWidget(),
        ],
      ),
    );
  }
}
