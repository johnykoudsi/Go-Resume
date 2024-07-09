import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/app_style.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/filter_spacing_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/handle_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_type_filter_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/sorts_filter_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../utility/app_strings.dart';

class AllJobsScreen extends StatefulWidget {
  const AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetAllJobsBloc getAllJobsBloc = GetAllJobsBloc();
  bool searchDeleteIcon = false;
  AllJobsSearchFilter jobFilter = AllJobsSearchFilter();

  @override
  void initState() {
    getAllJobsBloc.add(ChangeToLoadingAllJobsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getAllJobsBloc.add(
          GetAllJobsSearchEvent(
            searchFilter: jobFilter,
          ),
        );
      }
    });
    super.initState();
  }

  void search() {
    getAllJobsBloc.add(
      ChangeToLoadingAllJobsEvent(
        searchFilter: jobFilter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllJobsBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("jobs".tr()),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.myNotifications);
                },
                icon: SvgPicture.asset(Assets.svgNotification))
          ],
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 75),
            child: SearchTextField(
              onClear: () {
                setState(() {
                  searchDeleteIcon = false;
                  searchController.clear();
                });
                jobFilter = jobFilter.copyWith(search: '');
                search();
              },
              onSend: (value) {
                if (value == null || value.isEmpty) {
                  return;
                }
                setState(() {
                  searchDeleteIcon = true;
                });
                jobFilter = jobFilter.copyWith(search: value);
                search();
              },
              searchController: searchController,
              showSearchDeleteIcon: searchDeleteIcon,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            search();
          },
          child: BlocBuilder<GetAllJobsBloc, GetAllJobsState>(
            builder: (context, state) {
              if (state is GetAllJobsLoadedState && state.jobList.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    controller: scrollController,
                    itemCount: state.hasReachedMax
                        ? state.jobList.length
                        : state.jobList.length + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.jobList.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 130,
                            child: ShimmerLoader(),
                          ),
                        );
                      }
                      return JobWidget(
                        jobEntity: state.jobList[index],
                      );
                    });
              }
              if (state is GetAllJobsLoadedState) {
                return const NoDataWidget();
              }
              if (state is GetAllJobsLoadingState) {
                return ListView.builder(
                    padding: const EdgeInsets.all(18),
                    controller: scrollController,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(height: 130, child: ShimmerLoader()),
                      );
                    });
              }
              return SomethingWrongWidget(
                svgPath: Assets.svgNoInternet,
                elevatedButtonWidget: ElevatedButtonWidget(
                  title: "refresh".tr(),
                  onPressed: () {
                    context
                        .read<GetAllJobsBloc>()
                        .add(ChangeToLoadingAllJobsEvent());

                    //search(userS);
                  },
                ),
              );
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Filter FAB
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: AppBorders.k10TopBorderRectangle,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const HandleWidget(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      JobTypeFilterWidget(
                                        onChanged: (value) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            jobFilter =
                                                jobFilter.copyWith(type: value);
                                          });
                                          search();
                                        },
                                        value: jobFilter.type ?? JobTypes.none,
                                      ),
                                      const FilterSpacing(),
                                      // PropertyServiceFilterExploreWidget(
                                      //   onChanged: (value) {
                                      //     Navigator.of(context).pop();
                                      //     setState(() {
                                      //       propertiesSearchFilter =
                                      //           propertiesSearchFilter.copyWith(
                                      //               propertyService: value);
                                      //     });
                                      //     search();
                                      //   },
                                      //   value: propertiesSearchFilter
                                      //       .propertyService,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    });
              },
              backgroundColor: AppColors.kMainColor100,
              child: SizedBox(
                child: SvgPicture.asset(
                  Assets.svgSearch,
                  color: AppColors.kBackGroundColor,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            // Sort FAB
            FloatingActionButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: AppBorders.k10TopBorderRectangle,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return SortsFilterWidget(
                            value: jobFilter.sort ?? JobSorts.none,
                            onChanged: (value) {
                              Navigator.of(context).pop();
                              setState(() {
                                jobFilter = jobFilter.copyWith(sort: value);
                              });
                              search();
                            },
                          );
                        },
                      );
                    });
              },
              backgroundColor: AppColors.kMainColor100,
              child: SizedBox(
                child: SvgPicture.asset(
                  Assets.svgFilter,
                  color: AppColors.kBackGroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
