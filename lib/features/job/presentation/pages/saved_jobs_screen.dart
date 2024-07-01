import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/search_text_field.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../utility/app_strings.dart';
import '../bloc/get_saved_jobs/get_saved_jobs_bloc.dart';

class SavedJobsScreen extends StatefulWidget {
  const SavedJobsScreen({super.key});

  @override
  State<SavedJobsScreen> createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetSavedJobsBloc getSavedJobsBloc = GetSavedJobsBloc();

  @override
  void initState() {
    getSavedJobsBloc.add(ChangeToLoadingSavedJobsEvent());
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getSavedJobsBloc.add(
          GetSavedJobsSearchEvent(
            searchFilter: SavedJobsSearchFilter(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getSavedJobsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.savedJobs),
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
            context.read<GetSavedJobsBloc>().add(ChangeToLoadingSavedJobsEvent());
          },
          child: BlocBuilder<GetSavedJobsBloc, GetSavedJobsState>(
            builder: (context, state) {
              if (state is GetSavedJobsLoadedState) {
                if(state.jobList.isEmpty){
                  return const NoDataWidget();
                }
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
              if (state is GetSavedJobsLoadingState) {
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
                        .read<GetSavedJobsBloc>()
                        .add(ChangeToLoadingSavedJobsEvent());

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
