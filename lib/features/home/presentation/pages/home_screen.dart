import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/home/presentation/widgets/carousel_widget.dart';
import 'package:smart_recruitment_flutter_user/features/home/presentation/widgets/home_companies_widget.dart';
import 'package:smart_recruitment_flutter_user/features/home/presentation/widgets/top_jobs_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';

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
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.svgNotification,
                color: Colors.white,
              ))
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 75),
          child: SearchTextField(
            onClear: () {},
            onSend: (value) {},
            searchController: searchController,
            showSearchDeleteIcon: false,
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
            height: 12,
          ),
          TopJobsSectionWidget(),
          SizedBox(
            height: 12,
          ),
          HomeCompaniesSectionWidget(),
        ],
      ),
    );
  }
}
