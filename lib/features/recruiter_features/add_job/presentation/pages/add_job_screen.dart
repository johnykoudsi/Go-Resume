import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/recruiter_features/add_job/presentation/widgets/preferred_gender_widget.dart';

import '../../../../../core/router/app_routes.dart';
import '../widgets/benefits_widget.dart';
import '../widgets/description_field.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController minimumSalaryController = TextEditingController();
  TextEditingController maximumSalaryController = TextEditingController();
  TextEditingController workHoursController = TextEditingController();

  DateTime? _selectedDate; // Moved outside of the build method
  String? _selectedUserGender="None";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;

    // Removed the _selectedDate variable from here

    void _updateSelectedDate(DateTime date) {
      setState(() {
        print('Selected date: $_selectedDate');
        _selectedDate = date;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Your Job Vacancy",
          style: AppFontStyles.boldH2,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            CustomTextField(
              action: TextInputAction.done,
              controller: positionController,
              label: "Position",
              onlyNumber: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Position is required";
                }
                return null;
              },
              hintText: 'Example: Software Engineer',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: descriptionController,
              label: "Description",
              onlyNumber: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Position is required";
                }
                return null;
              },
              hintText: 'Describe your vacancy with a few words',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DatePickerWidget(label: 'Select Date', controller: dateController),
            SizedBox(
              height: heightBetweenFields * 2,
            ),
            BenefitsWidget(
              onPressed: () {},
            ),
            SizedBox(
              height: heightBetweenFields * 2,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: minimumSalaryController,
              label: "Minimum Salary",
              onlyNumber: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Minimum Salary is required";
                }
                return null;
              },
              hintText: 'Example: 1000,000 sp',
              textInputType: TextInputType.number,

            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: maximumSalaryController,
              label: "Maximum Salary",
              onlyNumber: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Maximum Salary is required";
                }
                return null;
              },
              hintText: 'Example: 2000,000 sp',
              textInputType: TextInputType.number,

            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: workHoursController,
              label: "Work Hours",
              onlyNumber: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Work Hours Salary is required";
                }
                return null;
              },
              hintText: 'Example: 8 hours',
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: heightBetweenFields*2,
            ),
            const Text('Preferred Gender',style: AppFontStyles.mediumH3,),
            PreferredGenderWidget(selectedPreferredGender: _selectedUserGender, onUserTypeSelected: (value){setState(() {
              _selectedUserGender=value;
            });
            })  ,
            SizedBox(
              height: heightBetweenFields*2,
            ),
            ElevatedButtonWidget(gradientColor: AppColors.kDarkLinearColor,title: "Get Expected Salary",onPressed: (){
            },),
            SizedBox(
              height: heightBetweenFields*2,
            ),
            ElevatedButtonWidget(title: "Submit",onPressed: (){
            },),
            SizedBox(
              height: heightBetweenFields*2,
            ),
          ],
        ),
      ),
    );
  }
}
