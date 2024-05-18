import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/preferred_gender_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../bloc/applicant_profile_bloc.dart';

class EditApplicantProfileScreen extends StatefulWidget {
  const EditApplicantProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditApplicantProfileScreen> createState() =>
      _EditApplicantProfileScreenState();
}

class _EditApplicantProfileScreenState
    extends State<EditApplicantProfileScreen> {
  GenderEnum? _selectedUserGender = GenderEnum.m;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      nameController.text = userBloc.user.data.fullName;
      bioController.text = userBloc.user.data.applicant?.bio ?? "";
      selectedDate = userBloc.user.data.applicant?.dob;
      _selectedUserGender = userBloc.user.data.applicant?.gender == "m"
          ? GenderEnum.m
          : userBloc.user.data.applicant?.gender == "f"
              ? GenderEnum.f
              : GenderEnum.none;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return BlocListener<ApplicantProfileBloc, ApplicantProfileState>(
      listener: (context, state) {
        if (state is ApplicantProfileResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            showServerError: true,
            popOnSuccess: true,
          );
          if(state.helperResponse.servicesResponse == ServicesResponseStatues.success){
            context.read<UserBloc>().add(RefreshUserEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: AppFontStyles.boldH2,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.03),
          children: [
            CustomTextField(
              action: TextInputAction.done,
              controller: nameController,
              label: "Full Name",
              onlyNumber: false,
              hintText: 'Example: John Due',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DatePickerWidget(
              label: 'Date Of Birth',
              selectedDate: selectedDate,
              onDateChange: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: bioController,
              label: "Bio",
              onlyNumber: false,
              hintText: 'Describe your self with a few words',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            PreferredGenderWidget(
                selectedPreferredGender: _selectedUserGender,
                onUserTypeSelected: (value) {
                  setState(() {
                    _selectedUserGender = value;
                  });
                }),
            SizedBox(
              height: screenHeight * 0.35,
            ),
            BlocBuilder<ApplicantProfileBloc, ApplicantProfileState>(
              builder: (context, state) {
                return ElevatedButtonWidget(
                  title: "Edit",
                  isLoading: state is ApplicantProfileLoading,
                  onPressed: () {
                    context
                        .read<ApplicantProfileBloc>()
                        .add(UpdateApplicantProfileEvent(
                          dob: selectedDate,
                          gender: _selectedUserGender,
                          bio: bioController.text,
                          fullName: nameController.text,
                          // websiteLink: null,
                          // instagram: null,
                          // facebook: null,
                          // linkedin: null,
                          // email: null,
                        ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
