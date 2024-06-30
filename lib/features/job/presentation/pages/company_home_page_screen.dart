import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/jobs_horizantal_widget.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/home/presentation/widgets/carousel_widget.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/home/presentation/widgets/my_jobs_section_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../utility/app_strings.dart';

class CompanyHomePageScreen extends StatefulWidget {
  const CompanyHomePageScreen({super.key});

  @override
  State<CompanyHomePageScreen> createState() => _CompanyHomePageScreenState();
}

class _CompanyHomePageScreenState extends State<CompanyHomePageScreen> {
  TextEditingController searchController = TextEditingController();

  int? companyId;
  @override
  void initState() {
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoggedState) {
      companyId = userState.user.data.company?.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "Jobs",
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
              Navigator.of(context).pushNamed(AppRoutes.allJobs);
            },
            child: SearchTextField(
              onClear: () {},
              onSend: (value) {},
              enabled: false,
              searchController: searchController,
              showSearchDeleteIcon: false,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.kLinearWideColor),
        ),
      ),
      body: ListView(
        children: [
          const CarouselSliderWidget(),
          const SizedBox(
            height: 30,
          ),
          const MyJobsSectionWidget(),
          JobsHorizontalWidget(
            companyId: companyId,
          ),
        ],
      ),
    );
  }
}
