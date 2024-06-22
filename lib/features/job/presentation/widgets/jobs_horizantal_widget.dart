import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

class JobsHorizontalWidget extends StatefulWidget {
  const JobsHorizontalWidget({super.key});

  @override
  State<JobsHorizontalWidget> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<JobsHorizontalWidget> {
  GetAllJobsBloc getAllJobsBloc = GetAllJobsBloc();
  AllJobsSearchFilter jobFilter = AllJobsSearchFilter();

  @override
  void initState() {
    getAllJobsBloc.add(ChangeToLoadingAllJobsEvent());
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
      child: BlocBuilder<GetAllJobsBloc, GetAllJobsState>(
        builder: (context, state) {
          if (state is GetAllJobsLoadedState && state.jobList.isNotEmpty) {
            return ListView.builder(
                padding: const EdgeInsets.all(18),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  try {
                    return JobWidget(
                      jobEntity: state.jobList[index],
                    );
                  } catch (e) {
                    return const SizedBox();
                  }
                });
          }
          if (state is GetAllJobsLoadedState) {
            return const NoDataWidget();
          }
          if (state is GetAllJobsLoadingState) {
            return Padding(
              padding: const EdgeInsets.all(18),
              child: SizedBox(height: 130, child: ShimmerLoader()),
            );
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
    );
  }
}
