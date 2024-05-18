import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

class AllJobsScreen extends StatefulWidget {
  const AllJobsScreen({super.key});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetAllJobsBloc getAllJobsBloc = GetAllJobsBloc();

  @override
  void initState() {
    getAllJobsBloc.add(ChangeToLoadingAllJobsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getAllJobsBloc.add(
          GetAllJobsSearchEvent(
            searchFilter: AllJobsSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllJobsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Jobs".tr()),
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
              onClear: () {},
              onSend: (value) {},
              searchController: searchController,
              showSearchDeleteIcon: false,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<GetAllJobsBloc>().add(ChangeToLoadingAllJobsEvent());
          },
          child: BlocBuilder<GetAllJobsBloc, GetAllJobsState>(
            builder: (context, state) {
              if (state is GetAllJobsLoadedState) {
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
                  title: "Refresh",
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
      ),
    );
  }
}
