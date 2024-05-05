import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/date_picker_widget.dart';

import '../../../recruiter_features/add_job/presentation/widgets/preferred_gender_widget.dart';

class EditApplicantProfileScreen extends StatefulWidget {
  const EditApplicantProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditApplicantProfileScreen> createState() => _EditApplicantProfileScreenState();
}



class _EditApplicantProfileScreenState extends State<EditApplicantProfileScreen> {
  String? _selectedUserGender="None";
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      nameController = TextEditingController(text: userBloc.user.data.fullName);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return  Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"),),
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
          SizedBox(height: heightBetweenFields,),
          DatePickerWidget(label: 'Date Of Birth', controller: dateController),
          SizedBox(height: heightBetweenFields,),
          PreferredGenderWidget(selectedPreferredGender: _selectedUserGender, onUserTypeSelected: (value){setState(() {
            _selectedUserGender=value;
          });
          }),
        ],
      ),
    );
  }
}
