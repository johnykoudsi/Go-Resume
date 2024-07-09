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

import '../../../../utility/app_strings.dart';

class JobsHorizontalWidget extends StatefulWidget {
  const JobsHorizontalWidget({this.companyId, super.key});
  final int? companyId;
  @override
  State<JobsHorizontalWidget> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<JobsHorizontalWidget> {
  GetAllJobsBloc getAllJobsBloc = GetAllJobsBloc();
  AllJobsSearchFilter jobFilter = AllJobsSearchFilter();

  @override
  void initState() {

    jobFilter = jobFilter.copyWith(companyId: widget.companyId);
    getAllJobsBloc.add(ChangeToLoadingAllJobsEvent(searchFilter: jobFilter));
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
            return ListView.builder(
                padding: const EdgeInsets.all(18),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
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
              title: AppStrings.refresh,
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
