import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_applicants_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/app_strings.dart';
import '../../../../utility/global_widgets/search_text_field.dart';
import '../bloc/get_job_applicants/get_job_applicants_bloc.dart';

class JobApplicantsScreen extends StatefulWidget {
  JobEntity jobEntity;
   JobApplicantsScreen({Key? key,required this.jobEntity}) : super(key: key);

  @override
  State<JobApplicantsScreen> createState() => _JobApplicantsScreenState();
}

class _JobApplicantsScreenState extends State<JobApplicantsScreen> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  GetJobApplicantsBloc getJobApplicantsBloc = GetJobApplicantsBloc();

  @override
  void initState() {
    getJobApplicantsBloc.add(ChangeToLoadingJobApplicantsEvent(jobId:widget.jobEntity.id));
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
          AppStrings.applicantFor+widget.jobEntity.position,
          style: AppFontStyles.boldH2,
          maxLines: 2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.jobEntity.applicants.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.jobEntity.applicants != []) {
              return JobApplicantsWidget(
                canReject: true,
                user: widget.jobEntity.applicants[index],
              );
            }
          },
        ),
      ),
    );
  }
}
