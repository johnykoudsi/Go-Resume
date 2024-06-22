import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';

import '../../../../../generated/assets.dart';
import '../../../company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import '../../../company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';
import '../../../edit_applicant_profile/presentation/bloc/applicant_profile_bloc.dart';

class ProfileImageWidget extends StatefulWidget {
  final int? userId;
  final bool visitor;
  final String profileImage;
  final String viewsNumber;
  final bool isCompany;
  const ProfileImageWidget({
    Key? key,
    required this.profileImage,
    required this.viewsNumber,
    this.visitor = false,
    required this.isCompany,
    this.userId,
  }) : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  final double _size = 0.07;

  Future galleryPicker() async {
    // cover photo picker compressor
    final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (myFile != null) {
      ImageCropper().cropImage(
        sourcePath: myFile.path,
        compressQuality: 50,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.kMainColor100,
            cropStyle: CropStyle.circle,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      ).then((croppedFile) async {
        if (croppedFile != null) {
          if (widget.isCompany) {
            context.read<ApplicantProfileBloc>().add(
                UpdateApplicantProfileEvent(
                    profileImage: [File(croppedFile.path)]));
          } else {
            context.read<CompanyProfileBloc>().add(UpdateCompanyProfileEvent(
                profileImage: [File(croppedFile.path)]));
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ToggleCompanyBloc>()
        .add(GetCompanyStatusEvent(id: widget.userId ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          bottom: 1,
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.06,
                decoration:
                    const BoxDecoration(gradient: AppColors.kLinearColor),
              ),
              Positioned(
                left: 10,
                top: 15,
                child: Text(
                  "${widget.viewsNumber} Views",
                  style: AppFontStyles.mediumH6.copyWith(color: Colors.white),
                ),
              ),
              //    SizedBox(width: screenWidth * 0.65),
              Positioned(
                right: 10,
                top: 10,
                // right:0,
                // bottom: 1,
                child: GestureDetector(
                  onTap: () {
                    if (widget.visitor) {
                      return context
                          .read<ToggleCompanyBloc>()
                          .add(ToggleCompanyApiEvent(id: widget.userId ?? 0));
                    }
                    if (widget.isCompany) {
                      Navigator.pushNamed(
                          context, AppRoutes.editCompanyProfile);
                      return;
                    }
                    if (!widget.isCompany) {
                      Navigator.pushNamed(
                          context, AppRoutes.editApplicantProfile);
                      return;
                    }
                  },
                  child: BlocBuilder<ToggleCompanyBloc, ToggleCompanyState>(
                    builder: (context, companyState) {
                      if (!widget.visitor) {
                        return SvgPicture.asset(
                          Assets.svgEdit,
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          color: Colors.white,
                        );
                      }
                      if (companyState is ToggleCompanyLoadedState &&
                          companyState.isFavorite) {
                        return SvgPicture.asset(
                            width: 30, height: 30, Assets.svgStarFill);
                      }
                      if (companyState is ToggleCompanyLoadedState) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: screenWidth * _size,
                          height: screenWidth * _size,
                          child: SvgPicture.asset(
                              color: Colors.white,
                              width: 30,
                              height: 30,
                              Assets.svgStar),
                        );
                      }
                      return const CircularProgressIndicator(
                        color: AppColors.kBackGroundColor,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Center(
          child: Stack(
            children: [
              CircularProfileImage(
                borderColor: Colors.white,
                image: widget.profileImage,
                width: screenWidth * 0.35,
                height: screenWidth * 0.35,
              ),
              !widget.visitor
                  ? Positioned(
                      bottom: 2,
                      right: 0,
                      child: GestureDetector(
                        onTap: galleryPicker,
                        child: Container(
                          width: screenWidth * 0.09,
                          height: screenWidth * 0.09,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.svgCamera,
                              width: screenWidth * 0.06,
                              height: screenWidth * 0.06,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(""),
            ],
          ),
        ),
      ],
    );
  }
}
