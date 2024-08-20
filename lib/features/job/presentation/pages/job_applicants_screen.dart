import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_applicants_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../core/enums.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/app_strings.dart';
import '../../../../utility/global_widgets/no_data_widget.dart';
import '../../../../utility/global_widgets/search_text_field.dart';
import '../bloc/get_job_applicants/get_job_applicants_bloc.dart';
import '../widgets/filter_spacing_widget.dart';
import '../widgets/handle_widget.dart';
import '../widgets/job_type_filter_widget.dart';
import '../widgets/sorts_filter_widget.dart';

class JobApplicantsScreen extends StatefulWidget {
  JobEntity jobEntity;

  JobApplicantsScreen({Key? key, required this.jobEntity}) : super(key: key);

  @override
  State<JobApplicantsScreen> createState() => _JobApplicantsScreenState();
}

class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  ScrollController scrollController = ScrollController();
  bool searchDeleteIcon = false;
  JobApplicantsSearchFilter jobFilter = JobApplicantsSearchFilter();
  TextEditingController searchController = TextEditingController();
  GetJobApplicantsBloc getJobApplicantsBloc = GetJobApplicantsBloc();

  @override
  void initState() {
    getJobApplicantsBloc
        .add(ChangeToLoadingJobApplicantsEvent(jobId: widget.jobEntity.id));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getJobApplicantsBloc.add(
          GetJobApplicantsSearchEvent(
            jobId: widget.jobEntity.id,
            searchFilter: JobApplicantsSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  void search() {
    context.read<GetJobApplicantsBloc>().add(ChangeToLoadingJobApplicantsEvent(
        jobId: widget.jobEntity.id, searchFilter: jobFilter));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: screenHeight * 0.15,
        title: Text(
          "applicantFor".tr() + widget.jobEntity.position,
          style: AppFontStyles.boldH2,
          maxLines: 2,
        ),
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
          // context.read<GetJobApplicantsBloc>().add(ChangeToLoadingJobApplicantsEvent(jobId: widget.jobEntity.id,searchFilter: jobFilter));
        },
        child: BlocBuilder<GetJobApplicantsBloc, GetJobApplicantsState>(
          builder: (context, state) {
            if (state is GetJobApplicantsLoadedState &&
                state.applicantsList.isNotEmpty) {
              return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(18),
                  controller: scrollController,
                  itemCount: state.hasReachedMax
                      ? state.applicantsList.length
                      : state.applicantsList.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= state.applicantsList.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          height: 130,
                          child: ShimmerLoader(),
                        ),
                      );
                    }
                    return JobApplicantsWidget(
                      refresh: () {
                        search();
                      },
                      job: widget.jobEntity,
                      applicant: state.applicantsList[index],
                    );
                  });
            }
            if (state is GetJobApplicantsLoadedState) {
              return const NoDataWidget();
            }
            if (state is GetJobApplicantsLoadingState) {
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
                  context.read<GetJobApplicantsBloc>().add(
                      ChangeToLoadingJobApplicantsEvent(
                          jobId: widget.jobEntity.id));

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
            heroTag: "asdasdasd",
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    JobTypeFilterWidget(
                                      onChanged: (value) {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          jobFilter = jobFilter.copyWith(
                                              type: value);
                                        });
                                        search();
                                      },
                                      value:
                                      jobFilter.type ?? JobTypes.none,
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

    );
  }
}
