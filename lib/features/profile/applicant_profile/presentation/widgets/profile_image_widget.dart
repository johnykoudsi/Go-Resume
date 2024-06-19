import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/circular_profile_image.dart';

import '../../../../../generated/assets.dart';
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

class _ProfileImageWidgetState extends State<ProfileImageWidget>
    with SingleTickerProviderStateMixin {
  double _size = 0.07;
  late AnimationController _controller;
  List<File>? _profileImage;
  Future<void> _pickProfileImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);
    setState(() {
      if (result != null) {
        _profileImage = result.paths.map((path) => File(path!)).toList();
      } else {}
    });
    context
        .read<ApplicantProfileBloc>()
        .add(UpdateApplicantProfileEvent(profileImage: _profileImage));
  }

  @override
  void initState() {
    super.initState();
    context
        .read<ToggleCompanyBloc>()
        .add(GetCompanyStatusEvent(id: widget.userId ?? 0));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _size = 0.07 + 0.02 * _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              // bottom: screenHeight * 0.01,
              // left: screenWidth * 0.02,
              // right: screenWidth * 0.02,

              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //      crossAxisAlignment: CrossAxisAlignment.center,

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
                    if (widget.isCompany) {
                      if (widget.visitor) {
                        context
                            .read<ToggleCompanyBloc>()
                            .add(ToggleCompanyApiEvent(id: widget.userId ?? 0));
                      } else {
                        Navigator.pushNamed(
                            context, AppRoutes.editCompanyProfile);
                      }
                    } else {
                      if (widget.visitor) {
                        //todo add pin toggle
                      } else {}
                      Navigator.pushNamed(
                          context, AppRoutes.editApplicantProfile);
                    }
                  },
                  child: BlocBuilder<ToggleCompanyBloc, ToggleCompanyState>(
                    builder: (context, companyState) {
                      if (widget.visitor) {
                        if (companyState is ToggleCompanyLoadedState) {
                          if (companyState.isFavorite) {
                            return SvgPicture.asset(
                                width: 30, height: 30, Assets.svgStarFill);
                          } else {
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
                        } else {
                          return const CircularProgressIndicator(
                            color: AppColors.kBackGroundColor,
                          );
                        }
                      } else {
                        return SvgPicture.asset(
                          Assets.svgEdit,
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          color: Colors.white,
                        );
                      }
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
                        onTap: _pickProfileImage,
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
