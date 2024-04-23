import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

import '../../../../../core/router/app_routes.dart';
import '../widgets/company_widget.dart';

class AllCompaniesScreen extends StatelessWidget {
  const AllCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite".tr()),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myNotifications);

              }, icon: SvgPicture.asset(Assets.svgNotification))
        ],
      ),
      body: AlignedGridView.count(
        padding: const EdgeInsets.all(18),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CompanyWidget();
        },
      ),
    );
  }
}
