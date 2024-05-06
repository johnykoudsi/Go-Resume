import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';

import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/date_picker_widget.dart';

import '../../../recruiter_features/add_job/presentation/widgets/description_field.dart';
import '../../../recruiter_features/add_job/presentation/widgets/preferred_gender_widget.dart';

class EditApplicantProfileScreen extends StatefulWidget {
  const EditApplicantProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditApplicantProfileScreen> createState() => _EditApplicantProfileScreenState();
}

class _EditApplicantProfileScreenState extends State<EditApplicantProfileScreen> {
  String? _selectedUserGender = "None";
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      nameController.text=userBloc.user.data.fullName;
      bioController.text=userBloc.user.data.applicant?.bio ?? "";
      dateController.text=userBloc.user.data.applicant?.dob ?? "";
      _selectedUserGender = userBloc.user.data.applicant?.gender ?? "None";

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return Scaffold(
      appBar: AppBar(title:  const Text("Edit Profile",style: AppFontStyles.boldH2,),),
      body: ListView(
        padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06, screenWidth * 0.04, screenWidth * 0.03),
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
          SizedBox(height: heightBetweenFields,),
          DatePickerWidget(label: 'Date Of Birth', controller: dateController),
          SizedBox(height: heightBetweenFields,),
          DescriptionField(
            action: TextInputAction.done,
            controller: bioController,
            label: "Bio",
            onlyNumber: false,
            hintText: 'Describe your self with a few words',
          ),
          SizedBox(height: heightBetweenFields,),
          PreferredGenderWidget(selectedPreferredGender: _selectedUserGender, onUserTypeSelected: (value) {
            setState(() {
              _selectedUserGender = value;
            });
          }),
          SizedBox(height: screenHeight*0.35,),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                title: "Edit",
                isLoading: state is UserLoading,
                onPressed: () {

                    // context.read<UserBloc>().add(LoginUserEvent(
                    //   password: passwordController.text,
                    //   phoneNumber: phoneController.text,
                    // ));

                },
              );
            },
          ),
        ],
      ),
    );
  }
}
