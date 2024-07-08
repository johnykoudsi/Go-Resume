import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/policy.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_item_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/home/presentation/widgets/top_jobs_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/back_button_circular.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../job/presentation/widgets/jobs_horizantal_widget.dart';
import '../../../applicant_profile/presentation/widgets/contact_info_widget.dart';
import '../../../applicant_profile/presentation/widgets/profile_image_widget.dart';

class CompanyProfileScreen extends StatefulWidget {
  final bool visitor;
  const CompanyProfileScreen({
    Key? key,
    this.visitor = false,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
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
          context.read<CompanyProfileBloc>().add(
              UpdateCompanyProfileEvent(coverImage: [File(croppedFile.path)]));
        }
      });
    }
  }

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }
  void openWhatsapp(
      {required BuildContext context, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp";
    var whatsappURLIos = "https://wa.me/$whatsapp}";

    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      DialogsWidgetsSnackBar.showScaffoldSnackBar(
          title: "Whatsapp not installed", context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listener: (context, companyProfileState) {
        if (companyProfileState is CompanyProfileResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            showServerError: true,
            context: context,
            helperResponse: companyProfileState.helperResponse,
            popOnSuccess: false,
          );
          if (companyProfileState.helperResponse.servicesResponse ==
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
                          userId: user.company?.id,
                          isCompany: user.company != null ? true : false,
                          visitor: widget.visitor,
                          profileImage: user.profileImage,
                          viewsNumber: user.views.toString()??"",
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
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  user.company!.about != ''
                      ? Column(
                          children: [
                            CustomCard(
                              operation: "",
                              title: AppStrings.aboutUs,
                              visitor: widget.visitor,
                              content: Text(
                                user.company!.about,
                                style: AppFontStyles.mediumH5,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  user.company!.vision != ''
                      ? Column(
                          children: [
                            CustomCard(
                                operation: "",
                                title: AppStrings.vision,
                                content: Text(
                                  user.company!.vision,
                                  style: AppFontStyles.mediumH5,
                                )),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  user.company!.mission != ''
                      ? Column(
                    children: [
                      CustomCard(
                          operation: "",
                          title: AppStrings.mission,
                          content: Text(
                            user.company!.mission,
                            style: AppFontStyles.mediumH5,
                          )),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                    ],
                  )
                      : const SizedBox.shrink(),
                  CustomCard(
                    title: AppStrings.policies,
                    visitor: widget.visitor,
                    content: user.company!.policies!.isEmpty
                        ? const NoDataWidget(
                            small: true,
                          )
                        : Column(
                            children: List.generate(
                              user.company?.policies?.length ?? 0,
                              (index) {
                                Policy? p = user.company?.policies?[index];
                                return DescriptionItemWidget(
                                  description: p!.description,
                                );
                              },
                            ),
                          ),
                    onOperationPressed: () {
                      Navigator.pushNamed(context, AppRoutes.myPolicies,
                          arguments: user.company?.policies);
                    },
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  JobsHorizontalWidget(
                    companyId: user.company?.id,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  CustomCard(
                    operation: "",
                    title: AppStrings.contactInfo,
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
                              openWhatsapp(
                                context: context,
                                number: user.mobile,
                              );
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
