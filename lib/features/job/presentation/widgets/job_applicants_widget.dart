import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_job_applicants/get_job_applicants_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';
import '../../../../../generated/assets.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../utility/global_widgets/dialogs_yes_no.dart';
import '../../../profile/applicant_profile/presentation/pages/applicant_profile_screen.dart';
import '../../domain/entities/job_entity.dart';

class JobApplicantsWidget extends StatelessWidget {
  final bool canReject;
  User applicant;
  JobEntity? job;
  final void Function()? refresh;
  JobApplicantsWidget(
      {Key? key, this.canReject = true, required this.applicant, this.job, this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: const Color(0xff232323),
          animationDuration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.k15BorderRadius,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.viewApplicantProfile,
              arguments: applicant);
        },
        child: Stack(
          children: [
            canReject
                ? Positioned(
                    right: context.locale.languageCode=="en"?0:null,
                    left: context.locale.languageCode=="ar"?0:null,
                    child: BlocConsumer<EditJobBloc,
                        EditJobState>(
                      listener: (context, state) {
                        if (state is EditJobResponseState) {
                          DialogsWidgetsSnackBar.showSnackBarFromStatus(
                            showServerError: true,
                            context: context,
                            helperResponse: state.helperResponse,
                            popOnSuccess: false,
                          );
                          if(state.helperResponse.servicesResponse == ServicesResponseStatues.success){
                            refresh!();
                          }
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              DialogsWidgetsYesNo.showYesNoDialog(
                                title:"areYouSureToReject".tr(),
                                noTitle: "no".tr(),
                                yesTitle: "yes".tr(),
                                isLoading: state is EditJobLoadingState,
                                onYesTap: () {
                                  Navigator.of(context).pop();
                                  context.read<EditJobBloc>().add(
                                    RejectApplicantEvent(
                                       jobId: job!.id, applicantId: applicant.applicant!.id,
                                    ),
                                  );
                                },
                                onNoTap: () {
                                  Navigator.of(context).pop();
                                },
                                context: context,
                              );
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppColors.kRedColor,
                            ));
                      },
                    ),
                  )
                : const Text(""),
            Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircularProfileImage(
                        isCompany: false,
                        borderColor: AppColors.kMainColor100,
                        image: applicant.profileImage,
                        width: screenWidth * 0.13,
                        height: screenWidth * 0.13,
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Text(
                        applicant.fullName,
                        style: AppFontStyles.boldH6,
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth * 0.01,
                  ),
                  Text(
                    job?.position ?? "",
                    style: AppFontStyles.boldH6,
                  ),
                  Text(
                    //todo change to job.location
                    "Damascus - Syria",
                    style: AppFontStyles.regularH6
                        .copyWith(color: AppColors.kGreyColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMd()
                            .format(job?.startDate ?? DateTime(1970)),
                        style: AppFontStyles.regularH6
                            .copyWith(color: AppColors.kGreyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
