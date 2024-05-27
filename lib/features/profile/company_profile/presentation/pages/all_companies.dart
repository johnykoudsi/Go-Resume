import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/widget/company_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../../utility/app_strings.dart';

class AllCompaniesScreen extends StatefulWidget {
  const AllCompaniesScreen({super.key});

  @override
  State<AllCompaniesScreen> createState() => _AllCompaniesScreenState();
}

class _AllCompaniesScreenState extends State<AllCompaniesScreen> {
  ScrollController scrollController = ScrollController();
  GetAllCompanyBloc getAllCompanyBloc = GetAllCompanyBloc();

  @override
  void initState() {
    getAllCompanyBloc.add(ChangeToLoadingAllCompanyEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getAllCompanyBloc.add(
          GetAllCompanySearchEvent(
            searchFilter: AllCompanySearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllCompanyBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.company),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.myNotifications);
                },
                icon: SvgPicture.asset(Assets.svgNotification))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getAllCompanyBloc.add(ChangeToLoadingAllCompanyEvent());
          },
          child: BlocBuilder<GetAllCompanyBloc, GetAllCompanyState>(
            builder: (context, state) {
              if (state is GetAllCompanyLoadedState) {
                return AlignedGridView.count(
                  padding: const EdgeInsets.all(18),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: state.companyList.length,
                  itemBuilder: (context, index) {
                    return CompanyWidget(
                      user: state.companyList[index],
                    );
                  },
                );
              }
              if (state is GetAllCompanyLoadingState) {
                return AlignedGridView.count(
                  padding: const EdgeInsets.all(18),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ShimmerLoader(
                      height: 170,
                    );
                  },
                );
              }
              return SomethingWrongWidget(
                svgPath: Assets.svgNoInternet,
                elevatedButtonWidget: ElevatedButtonWidget(
                  title: "Refresh",
                  onPressed: () {
                    getAllCompanyBloc.add(ChangeToLoadingAllCompanyEvent());
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
