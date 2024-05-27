import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/top_applicants_widget.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../widgets/description_item_widget.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobEntity jobEntity;
  const JobDetailsScreen({required this.jobEntity, Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  ToggleJobBloc toggleJobBloc = ToggleJobBloc();

  @override
  void initState() {
    toggleJobBloc.add(GetJobStatusEvent(id: widget.jobEntity.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<ApplyForJobBloc, ApplyForJobState>(
      listener: (context, state) {
        if (state is ApplyForJobResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: false,
          );
          context.read<UserBloc>().add(RefreshUserEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, AppRoutes.myNotifications);
                },
                icon: BlocConsumer<ToggleJobBloc, ToggleJobState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if(state is ToggleJobLoadingState){
                      return CircularProgressIndicator();
                    }
                    if(state is ToggleJobErrorState){
                      return CircularProgressIndicator();
                    }
                    else{
                      print("hhhhh"+state.toString());

                      return
                        SvgPicture.asset(
                          Assets.svgSave,
                          color: AppColors.kMainColor100,
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.07,
                        );
                    }

                  },
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(widget.jobEntity.position,
                      style: AppFontStyles.mediumH5),
                  const Spacer(),
                  Text(
                    DateFormat.yMd()
                        .format(widget.jobEntity.startDate ?? DateTime(1970)),
                    style: AppFontStyles.mediumH5
                        .copyWith(color: AppColors.kGreyColor),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Text(
                    "Damascus-Syria-Company",
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Text(
                    "${NumberFormat.decimalPattern().format(widget.jobEntity.minSalary)} SYP"
                    " - ${NumberFormat.decimalPattern().format(widget.jobEntity.maxSalary)} SYP",
                    style: AppFontStyles.mediumH5,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.fiber_manual_record,
                        size: 10,
                        color: AppColors.kGreenColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Open",
                        style: AppFontStyles.boldH7
                            .copyWith(color: AppColors.kGreenColor),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                height: screenWidth * 0.005, // Adjust height as needed
                decoration: BoxDecoration(
                  color: Colors.red, // Divider color
                  borderRadius: BorderRadius.circular(
                      screenWidth * 0.01), // Rounded corners
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  const Text(
                    "Work Hours Daily: ",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    widget.jobEntity.workHours.toString(),
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    "Start date: ",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    DateFormat.yMd()
                        .format(widget.jobEntity.startDate ?? DateTime(1970)),
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    "Experience Years: ",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "${widget.jobEntity.experienceYears} years",
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  const Text(
                    "Type: ",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    widget.jobEntity.type.name,
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Description",
                    style: AppFontStyles.boldH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Row(
                children: [
                  Text(
                    "⚡",
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "Requirements:",
                    style: AppFontStyles.mediumH5,
                  ),
                ],
              ),
              DescriptionItemWidget(description: widget.jobEntity.description),
              const SizedBox(
                height: 100,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoggedState) {
                    if (state.user.data.applicant != null) {
                      return BlocBuilder<ApplyForJobBloc, ApplyForJobState>(
                        builder: (context2, state2) {
                          return ElevatedButtonWidget(
                            isLoading: state2 is ApplyForJobLoadingState,
                            title: "Apply",
                            onPressed: () {
                              context2.read<ApplyForJobBloc>().add(
                                  ApplyForJobApiEvent(id: widget.jobEntity.id));
                            },
                          );
                        },
                      );
                    }
                    if (state.user.data.company != null) {
                      return Column(
                        children: [
                          Container(
                            height:
                                screenWidth * 0.011, // Adjust height as needed
                            decoration: BoxDecoration(
                              color: Colors.red, // Divider color
                              borderRadius: BorderRadius.circular(
                                  screenWidth * 0.01), // Rounded corners
                            ),
                          ),
                          const TopApplicantsWidget(),
                        ],
                      );
                    }
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
