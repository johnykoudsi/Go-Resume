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
import '../bloc/get_All_applicants/get_all_applicants_bloc.dart';

class AllApplicantsScreen extends StatefulWidget {
  const AllApplicantsScreen({Key? key}) : super(key: key);

  @override
  State<AllApplicantsScreen> createState() => _AllApplicantsScreenState();
}

class _AllApplicantsScreenState extends State<AllApplicantsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetAllApplicantsBloc getAllApplicantsBloc = GetAllApplicantsBloc();

  @override
  void initState() {
    getAllApplicantsBloc.add(ChangeToLoadingAllApplicantsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getAllApplicantsBloc.add(
          GetAllApplicantsSearchEvent(
            searchFilter: AllApplicantsSearchFilter(),
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
      value: getAllApplicantsBloc,
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
          title: Text(
            AppStrings.allApplicants,
            style: AppFontStyles.boldH2,
            maxLines: 2,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            getAllApplicantsBloc.add(ChangeToLoadingAllApplicantsEvent());
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: BlocBuilder<GetAllApplicantsBloc, GetAllApplicantsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (state is GetAllApplicantsLoadedState) {
                      return JobApplicantsWidget(
                        canReject: true,
                        user: state.applicantsList[index],
                      );
                    }
                    if (state is GetAllApplicantsLoadedState) {
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
                            getAllApplicantsBloc
                                .add(ChangeToLoadingAllApplicantsEvent());
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
