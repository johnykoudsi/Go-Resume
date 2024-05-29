import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/app_strings.dart';
import '../../../../utility/global_widgets/search_text_field.dart';
import '../../../job/presentation/widgets/job_applicants_widget.dart';
import '../bloc/get_pinned_applicants/get_pinned_applicants_bloc.dart';

class PinnedApplicantsScreen extends StatefulWidget {
  const PinnedApplicantsScreen({Key? key}) : super(key: key);

  @override
  State<PinnedApplicantsScreen> createState() => _PinnedApplicantsScreenState();
}

class _PinnedApplicantsScreenState extends State<PinnedApplicantsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetPinnedApplicantsBloc getPinnedApplicantsBloc = GetPinnedApplicantsBloc();

  @override
  void initState() {
    getPinnedApplicantsBloc.add(ChangeToLoadingPinnedApplicantsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getPinnedApplicantsBloc.add(
          GetPinnedApplicantsSearchEvent(
            searchFilter: PinnedApplicantsSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: getPinnedApplicantsBloc,
      child: Scaffold(
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
          title:  Text(
            AppStrings.pinnedApplicants
            ,
            style: AppFontStyles.boldH2,
            maxLines: 2,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getPinnedApplicantsBloc.add(ChangeToLoadingPinnedApplicantsEvent());
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<GetPinnedApplicantsBloc, GetPinnedApplicantsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (state is GetPinnedApplicantsLoadedState) {
                      return JobApplicantsWidget(
                        canReject: true,
                        user: state.applicantsList[index],
                      );
                    }
                    if (state is GetPinnedApplicantsLoadedState) {
                      return AlignedGridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ShimmerLoader(
                            height: 170,
                          );
                        },
                      );
                    } else {
                      return SomethingWrongWidget(
                        svgPath: Assets.svgNoInternet,
                        elevatedButtonWidget: ElevatedButtonWidget(
                          title: AppStrings.refresh,
                          onPressed: () {
                            getPinnedApplicantsBloc
                                .add(ChangeToLoadingPinnedApplicantsEvent());
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
