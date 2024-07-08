import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/toggle_job/toggle_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/top_applicants_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/toggle_button_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/app_strings.dart';
import '../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../bloc/get_job_applicants/get_job_applicants_bloc.dart';
import '../widgets/description_item_widget.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobEntity jobEntity;
  const JobDetailsScreen({required this.jobEntity, Key? key}) : super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isCompany = false;
  JobApplicantsSearchFilter applicantsFilter = JobApplicantsSearchFilter();
  @override
  void initState() {
    applicantsFilter.page = 1;
    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      isCompany = userBloc.user.data.company != null ? true : false;
    }
    if (isCompany) {
      context
          .read<ToggleJobBloc>()
          .add(GetJobClosedStatusEvent(id: widget.jobEntity.id));
      context.read<GetJobApplicantsBloc>().add(GetJobApplicantsSearchEvent(
          jobId: widget.jobEntity.id, searchFilter: applicantsFilter));
    } else {
      context
          .read<ToggleJobBloc>()
          .add(GetJobStatusEvent(id: widget.jobEntity.id));

      context
          .read<ApplyForJobBloc>()
          .add(IsAppliedToJobEvent(id: widget.jobEntity.id));
    }

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
            isCompany
                ? GestureDetector(onTap: () {
                    context
                        .read<ToggleJobBloc>()
                        .add(ToggleJobStatusApiEvent(id: widget.jobEntity.id));
                  }, child: BlocBuilder<ToggleJobBloc, ToggleJobState>(
                    builder: (context, state) {
                      if (state is ToggleJobLoadedState) {
                        if (state.isSaved == false) {
                          return ToggleSliderWidget(
                            isClosed: false,
                          );
                        }
                        if (state.isSaved == true) {
                          return ToggleSliderWidget(
                            isClosed: true,
                          );
                        }
                      }
                      return const Padding(
                        padding: EdgeInsets.only(right: 15.0, left: 15.0),
                        child: CircularProgressIndicator(),
                      );
                    },
                  ))
                : IconButton(onPressed: () {
                    context
                        .read<ToggleJobBloc>()
                        .add(ToggleJobApiEvent(id: widget.jobEntity.id));
                  }, icon: BlocBuilder<ToggleJobBloc, ToggleJobState>(
                    builder: (context, state) {
                      if (state is ToggleJobLoadedState) {
                        if (state.isSaved == false) {
                          return SvgPicture.asset(
                            Assets.svgSave,
                            color: AppColors.kMainColor100,
                            width: screenWidth * 0.07,
                            height: screenWidth * 0.07,
                          );
                        }
                        if (state.isSaved == true) {
                          return SvgPicture.asset(
                            Assets.svgSaveFill,
                            color: AppColors.kMainColor100,
                            width: screenWidth * 0.07,
                            height: screenWidth * 0.07,
                          );
                        }
                      }
                      return const CircularProgressIndicator();
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
                    widget.jobEntity.city != ""
                        ? "${widget.jobEntity.company} - ${widget.jobEntity.country}"
                        : "",
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
                    "${NumberFormat.decimalPattern().format(widget.jobEntity.minSalary)} ${AppStrings.syp} - ${NumberFormat.decimalPattern().format(widget.jobEntity.maxSalary)} ${AppStrings.syp}",
                    style: AppFontStyles.mediumH5,
                  ),
                  const Spacer(),
                  BlocBuilder<ToggleJobBloc, ToggleJobState>(
                    builder: (context, state) {
                      if (isCompany) {
                        if (state is ToggleJobLoadedState) {
                          if (state.isSaved == true) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  AppStrings.close,
                                  style: AppFontStyles.boldH7
                                      .copyWith(color: Colors.red),
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.fiber_manual_record,
                                  size: 10,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  AppStrings.open,
                                  style: AppFontStyles.boldH7
                                      .copyWith(color: Colors.green),
                                ),
                              ],
                            );
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.fiber_manual_record,
                              size: 10,
                              color: widget.jobEntity.status == 'open'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              widget.jobEntity.status == 'open'
                                  ? AppStrings.open
                                  : AppStrings.close,
                              style: AppFontStyles.boldH7.copyWith(
                                  color: widget.jobEntity.status == 'open'
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        );
                      }
                    },
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
                   Text(
                     AppStrings.dailyWorkHours,
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
                   Text(
                    "${AppStrings.startDate}: ",
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
                   Text(
                     AppStrings.experienceYears,
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "${widget.jobEntity.experienceYears} ${AppStrings.years}",
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
                     AppStrings.type,
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    jobTypesUi.reverse[widget.jobEntity.type] ?? '',
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.kGreyColor),
                    borderRadius: AppBorders.k8BorderRadius),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(AppStrings.salaryExpectations,
                        style: AppFontStyles.boldH4),
                    Text(
                      "${NumberFormat.decimalPattern().format(widget.jobEntity.minExpected)} ${AppStrings.mSYP} - ${NumberFormat.decimalPattern().format(widget.jobEntity.maxExpected)} ${AppStrings.mSYP}",
                      style: AppFontStyles.mediumH5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              if (widget.jobEntity.description != "")
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.description,
                          style:
                              AppFontStyles.boldH5.copyWith(color: Colors.red),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                      ],
                    ),
                     Row(
                      children: [
                        const Text(
                          "⚡",
                          style: AppFontStyles.mediumH5,
                        ),
                        Text(
                          AppStrings.requirements,
                          style: AppFontStyles.mediumH5,
                        ),
                      ],
                    ),
                    DescriptionItemWidget(
                        description: widget.jobEntity.description),
                  ],
                )
              else
                const SizedBox(),
              isCompany
                  ? BlocBuilder<GetJobApplicantsBloc, GetJobApplicantsState>(
                      builder: (context, state) {
                        if (state is GetJobApplicantsLoadedState) {
                          if (state.applicantsList.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: screenWidth * 0.1,
                                ),
                                Container(
                                  height: screenWidth *
                                      0.005, // Adjust height as needed
                                  decoration: BoxDecoration(
                                    color: Colors.red, // Divider color
                                    borderRadius: BorderRadius.circular(
                                        screenWidth * 0.01), // Rounded corners
                                  ),
                                ),
                                TopApplicantsWidget(
                                  applicants: state.applicantsList,
                                  jobEntity: widget.jobEntity,
                                ),
                              ],
                            );
                          }
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ShimmerLoader(
                                      width: 80,
                                      height: 20,
                                    ),
                                    ShimmerLoader(
                                      width: 80,
                                      height: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ShimmerLoader(
                                  width: screenWidth,
                                  height: 150,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 100,
              ),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoggedState) {
                    if (state.user.data.applicant != null) {
                      return BlocBuilder<ApplyForJobBloc, ApplyForJobState>(
                        builder: (applyForJobContext, applyForJobState) {
                          if (applyForJobState is IsAppliedToJobResponseState) {
                            if (applyForJobState.isAppliedTo) {
                              return const SizedBox.shrink();
                            } else {
                              return ElevatedButtonWidget(
                                isLoading:
                                    applyForJobState is ApplyForJobLoadingState,
                                title: "Apply",
                                onPressed: () {
                                  applyForJobContext
                                      .read<ApplyForJobBloc>()
                                      .add(ApplyForJobApiEvent(
                                          id: widget.jobEntity.id));
                                },
                              );
                            }
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
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
