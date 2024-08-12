import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/education.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/experience.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/contact_info_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/education_and_certificates_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/experience_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/profile_image_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/skill_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/back_button_circular.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';

class ApplicantProfileScreen extends StatefulWidget {
  const ApplicantProfileScreen({
    required this.user,
    Key? key,
    this.visitor = true,
  }) : super(key: key);

  final User user;
  final bool visitor;

  @override
  State<ApplicantProfileScreen> createState() => _ApplicantProfileScreenState();
}

class _ApplicantProfileScreenState extends State<ApplicantProfileScreen> {
  late User user;

  Future galleryPicker() async {
    // cover photo picker compressor
    final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myFile != null) {
      ImageCropper().cropImage(
        sourcePath: myFile.path,
        compressQuality: 50,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 2),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.kMainColor100,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
        ],
      ).then((croppedFile) async {
        if (croppedFile != null) {
          context.read<ApplicantProfileBloc>().add(UpdateApplicantProfileEvent(
              coverImage: [File(croppedFile.path)]));
        }
      });
    }
  }

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<ApplicantProfileBloc, ApplicantProfileState>(
      listener: (context, applicantProfileState) {
        if (applicantProfileState is ApplicantProfileResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            showServerError: true,
            context: context,
            helperResponse: applicantProfileState.helperResponse,
            popOnSuccess: false,
          );
          if (applicantProfileState.helperResponse.servicesResponse ==
              ServicesResponseStatues.success) {
            context.read<UserBloc>().add(RefreshUserEvent());
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kBackGroundColor,
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(RefreshUserEvent());
              },
              child: ListView(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.35,
                        child: FadeInImage(
                          placeholder: const AssetImage(Assets.jpgCoverImage),
                          image: NetworkImage(user.coverImage),
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              Assets.jpgCoverImage,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.21),
                        child: ProfileImageWidget(
                          userId: user.applicant?.id,
                          isCompany: user.company != null ? true : false,
                          visitor: widget.visitor,
                          profileImage: user.profileImage,
                          viewsNumber: user.views.toString() ?? "",
                        ),
                      ),
                      !widget.visitor
                          ? Positioned(
                              bottom: screenHeight * 0.08,
                              right: 4,
                              child: GestureDetector(
                                onTap: galleryPicker,
                                child: Container(
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.svgCamera,
                                      width: screenWidth * 0.07,
                                      height: screenWidth * 0.07,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Text(""),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Center(
                    child: Text(
                      user.fullName,
                      style: AppFontStyles.boldH2.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      user.applicant?.bio ?? "",
                      style: AppFontStyles.boldH5.copyWith(color: Colors.black),
                    ),
                  ),
                  user.applicant?.bio != null
                      ? const SizedBox(
                          height: 18,
                        )
                      : const SizedBox.shrink(),
                  CustomCard(
                    title: "experiences".tr(),
                    visitor: widget.visitor,
                    content: user.applicant!.experiences!.isEmpty
                        ? const NoDataWidget(
                            small: true,
                          )
                        : Column(
                            children: List.generate(
                              user.applicant?.experiences?.length ?? 0,
                              (index) {
                                Experience? e = user.applicant?.experiences?[index];
                                return ExperienceWidget(
                                  experience: e!,
                                );
                              },
                            ),
                          ),
                    onOperationPressed: () {
                      Navigator.pushNamed(context, AppRoutes.myExperiences,
                          arguments: user.applicant?.experiences);
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomCard(
                    title: "skills".tr(),
                    visitor: widget.visitor,
                    content: user.applicant!.skills!.isEmpty
                        ? const NoDataWidget(
                            small: true,
                          )
                        : Column(
                            children: List.generate(
                              user.applicant?.skills?.length ?? 0,
                              (index) {
                                Skill? s = user.applicant?.skills?[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: SkillWidget(
                                    skill: s!,
                                  ),
                                );
                              },
                            ),
                          ),
                    onOperationPressed: () {
                      Navigator.pushNamed(context, AppRoutes.mySkills,
                          arguments: user.applicant?.skills);
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomCard(
                    title: "educationCertificates".tr(),
                    visitor: widget.visitor,
                    content: user.applicant!.education!.isEmpty
                        ? const NoDataWidget(
                            small: true,
                          )
                        : Column(
                            children: List.generate(
                              user.applicant?.education?.length ?? 0,
                              (index) {
                                Education? e = user.applicant?.education?[index];
                                return EducationAndCertificatesWidget(
                                  education: e!,
                                );
                              },
                            ),
                          ),
                    onOperationPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutes.myEducationAndCertificates,
                          arguments: user.applicant?.education);
                    },
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomCard(
                    operation: "",
                    title: "contactInfo".tr(),
                    visitor: widget.visitor,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ContactInfoWidget(
                            onTap: () {
                              try {
                                launchUrl(
                                    Uri(
                                      scheme: "https",
                                      path: user.facebook,
                                    ),
                                    mode: LaunchMode.externalApplication);
                                {
                                  throw 'Could not launch ${user.facebook}';
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            imagePath: Assets.svgFacebook),
                        ContactInfoWidget(
                            onTap: () {
                              try {
                                launchUrl(
                                    Uri(
                                      scheme: "https",
                                      path: user.linkedin,
                                    ),
                                    mode: LaunchMode.externalApplication);
                                {
                                  throw 'Could not launch ${user.linkedin}';
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            imagePath: Assets.svgLinkedin),
                        ContactInfoWidget(
                            onTap: () {
                              Uri whatsapp=Uri.parse('https://wa.me/${user.mobile}');
                              launchUrl(whatsapp);
                            },
                            imagePath: Assets.svgWhatsapp),
                        ContactInfoWidget(
                            onTap: () {
                              try {
                                launchUrl(Uri(scheme: "tel", path: user.mobile));
                                {
                                  throw 'Could not launch ${user.mobile}';
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            imagePath: Assets.svgPhone),
                        ContactInfoWidget(
                            onTap: () {
                              try {
                                launchUrl(Uri(scheme: "mailto", path: user.email));
                                {
                                  throw 'Could not launch ${user.email}';
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            imagePath: Assets.svgGmail),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
            const BackButtonCircular(),
          ],
        ),
      ),
    );
  }
}
