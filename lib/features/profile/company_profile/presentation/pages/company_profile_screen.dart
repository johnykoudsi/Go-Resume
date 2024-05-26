import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/policy.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_item_widget.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/home/presentation/widgets/top_jobs_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../applicant_profile/presentation/widgets/contact_info_widget.dart';
import '../../../applicant_profile/presentation/widgets/profile_image_widget.dart';

class CompanyProfileScreen extends StatefulWidget {
  final bool visitor;
  const CompanyProfileScreen({
    Key? key,
    this.visitor = false, required this.user,
  }) : super(key: key);
  final User user;
  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  late User user;
  @override
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.kBackGroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserBloc>().add(RefreshUserEvent());
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/jpg/cover_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.21),
                  child: ProfileImageWidget(
                    isCompany: user.company!= null ? true :false,
                    visitor: widget.visitor,
                    profileImage: Assets.jpgCompanyProfile,
                    viewsNumber: '55',
                  ),
                ),
                !widget.visitor
                    ? Positioned(
                        bottom: screenHeight * 0.08,
                        right: 4,
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
            user.company!.about != ''?
            Column(
              children: [
                CustomCard(
                  operation: "",
                  title: "About Us",
                  visitor: widget.visitor,
                  content:
                  Text(
                    user.company!.about,
                    style: AppFontStyles.mediumH5,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ):const SizedBox.shrink(),
         user.company!.vision != ''?
            Column(
              children: [
                 CustomCard(
                   operation: "",
                    title: "Vision",
                    content: Text(
                      user.company!.vision,
                      style: AppFontStyles.mediumH5,
                    )),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ):const SizedBox.shrink(),

            CustomCard(
              title: "Policies",
              visitor: widget.visitor,
              content: Column(
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
            // CustomProfileCard(
            //     title: "Contact Info",
            //     operation: widget.visitor ? "" : "Manage",
            //     contactInfo: contacts
            // ),
            const TopJobsSectionWidget(),
          ],
        ),
      ),
    );
  }
}