import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/widget/company_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../../utility/app_strings.dart';
import '../bloc/get_favorite_companies/get_favorite_companies_bloc.dart';

class FavoriteCompaniesScreen extends StatefulWidget {
  const FavoriteCompaniesScreen({super.key});

  @override
  State<FavoriteCompaniesScreen> createState() => _FavoriteCompaniesScreenState();
}

class _FavoriteCompaniesScreenState extends State<FavoriteCompaniesScreen> {
  ScrollController scrollController = ScrollController();
  GetFavoriteCompaniesBloc getFavoriteCompaniesBloc = GetFavoriteCompaniesBloc();

  @override
  void initState() {
    getFavoriteCompaniesBloc.add(ChangeToLoadingFavoriteCompaniesEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getFavoriteCompaniesBloc.add(
          GetFavoriteCompaniesSearchEvent(
            searchFilter: FavoriteCompaniesSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getFavoriteCompaniesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("favoriteCompanies".tr()),
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
            getFavoriteCompaniesBloc.add(ChangeToLoadingFavoriteCompaniesEvent());
          },
          child: BlocBuilder<GetFavoriteCompaniesBloc, GetFavoriteCompaniesState>(
            builder: (context, state) {
              if (state is GetFavoriteCompaniesLoadedState) {
                if(state.companyList.isEmpty){
                  return const NoDataWidget();
                }
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
              if (state is GetFavoriteCompaniesLoadingState) {
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
                  title: "refresh".tr(),
                  onPressed: () {
                    getFavoriteCompaniesBloc.add(ChangeToLoadingFavoriteCompaniesEvent());
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
