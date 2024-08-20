import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import '../../../../core/router/app_routes.dart';
import '../../../../generated/assets.dart';
import '../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../profile/company_profile/presentation/widget/company_widget.dart';
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
  String benefits = 'none';
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
    for (int i = 0; i < widget.jobEntity.benefits.length; i++) {
      benefits =
          widget.jobEntity.benefits.map((benefit) => benefit.name).join(', ');
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
                ? IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.editJob,
                              arguments: widget.jobEntity)
                          .then((_) {
                        if (isCompany) {
                          context.read<ToggleJobBloc>().add(
                              GetJobClosedStatusEvent(id: widget.jobEntity.id));
                          context.read<GetJobApplicantsBloc>().add(
                              GetJobApplicantsSearchEvent(
                                  jobId: widget.jobEntity.id,
                                  searchFilter: applicantsFilter));
                        }
                      });
                      ;
                    },
                    icon: const Icon(Icons.edit))
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
                        ? "${widget.jobEntity.city} - ${widget.jobEntity.country}"
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
                    "${NumberFormat.decimalPattern().format(widget.jobEntity.minSalary)} ${"syp".tr()} - ${NumberFormat.decimalPattern().format(widget.jobEntity.maxSalary)} ${"syp".tr()}",
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
                                  "isClosed".tr(),
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
                                  "isOpen".tr(),
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
                                  ? "isOpen".tr()
                                  : "isClosed".tr(),
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
                    "dailyWorkHours".tr(),
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
                    "${"startDate".tr()}: ",
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
                    "experienceYears".tr(),
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    "${widget.jobEntity.experienceYears} ${"years".tr()}",
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
                    "type".tr(),
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    jobTypesUi.reverse[widget.jobEntity.type] ?? '',
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
                    "compensation:".tr(),
                    style: AppFontStyles.mediumH5,
                  ),
                  Text(
                    compensationTypesUi
                            .reverse[widget.jobEntity.compensation] ??
                        '',
                    style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Visibility(
                visible: benefits != 'none',
                child: Row(
                  children: [
                    Text(
                      "benefits:".tr(),
                      style: AppFontStyles.mediumH5,
                    ),
                    Text(
                      benefits,
                      style: AppFontStyles.mediumH5.copyWith(color: Colors.red),
                    ),
                  ],
                ),
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
                    Text("salaryExpectations".tr(),
                        style: AppFontStyles.boldH4),
                    Text(
                      "${NumberFormat.decimalPattern().format(widget.jobEntity.minExpected)} ${"mSYP".tr()} - ${NumberFormat.decimalPattern().format(widget.jobEntity.maxExpected)} ${"mSYP".tr()}",
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
                          "description".tr(),
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
                          "requirements".tr(),
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
              Visibility(
                visible: !isCompany,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text("Publisher".tr(),style: AppFontStyles.boldH4,),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    CompanyWidget(
                      user: widget.jobEntity.company,
                    )
                  ],
                ),
              ),
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
              // : CompanyWidget(
              //     user: widget.jobEntity.company!,
              //   ),
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
                              return ElevatedButtonWidget(
                                isLoading:
                                    applyForJobState is ApplyForJobLoadingState,
                                title: "cancelApplication".tr(),
                                onPressed: () {
                                  applyForJobContext
                                      .read<ApplyForJobBloc>()
                                      .add(CancelApplicationEvent(
                                          id: widget.jobEntity.id));
                                },
                              );
                            } else {
                              return ElevatedButtonWidget(
                                isLoading:
                                    applyForJobState is ApplyForJobLoadingState,
                                title: "apply".tr(),
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
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
