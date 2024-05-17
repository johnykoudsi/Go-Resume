import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/entities/work_field_entity.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/benefits_widget.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/compensation_drop_down.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/job_drop_down.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/widgets/preferred_gender_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../../utility/global_widgets/searchable_drop_down_widget.dart';
import '../../../../../utility/global_widgets/shimmer.dart';
import '../../domain/entities/benefits_entity.dart';
import '../bloc/work_fields/work_fields_bloc.dart';
import 'benefits_screen.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({Key? key}) : super(key: key);

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController positionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController minimumSalaryController = TextEditingController();
  TextEditingController maximumSalaryController = TextEditingController();
  TextEditingController workHoursController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();

  GenderEnum selectedGender = GenderEnum.none;
  Compensation? selectedCompensation;
  List<BenefitEntity> _selectedBenefits = [];
  DateTime? selectedDate;
  JobTypes? selectedJobType;
  WorkFieldEntity? _selectedWorkField;

  void _handleSelectionBenefits(List<BenefitEntity> selectedItems) {
    setState(() {
      _selectedBenefits = selectedItems;
    });
  }

  void _handleSelectedWorkField(WorkFieldEntity workFieldEntity) {
    setState(() {
      _selectedWorkField = workFieldEntity;
    });
  }

  @override
  void initState() {
    search();
    super.initState();
  }

  void search() {
    context.read<BenefitsBloc>().add(GetBenefitsEvent());
    context.read<WorkFieldsBloc>().add(GetWorkFieldsEvent());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;

    return BlocListener<AddJobBloc, AddJobState>(
      listener: (context, state) {
        if (state is AddJobResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: false,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Add Your Job Vacancy",
            style: AppFontStyles.boldH3,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _key,
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
                DatePickerWidget(
                  minDate: DateTime.now().add(const Duration(days: 1)),
                  maxDate: DateTime.now().add(const Duration(days: 360)),
                  label: 'Select Date',
                  selectedDate: selectedDate,
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                BlocBuilder<BenefitsBloc, BenefitsState>(
                  builder: (context, state) {
                    if (state is BenefitsInitial) {
                      return ShimmerLoader(
                        height: screenHeight * 0.13,
                        width: screenWidth * 0.4,
                      );
                    }
                    if (state is BenefitsDoneState) {
                      return BenefitsWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => BenefitsBloc(),
                                child: BenefitsScreen(
                                  initiallySelectedItems: _selectedBenefits,
                                  benefits: state.benefits,
                                  onSelectionChanged: _handleSelectionBenefits,
                                ),
                              ),
                            ),
                          );
                        },
                        description: _selectedBenefits.isEmpty
                            ? "Add some benefits that your company will provide for the position you're offering."
                            : _selectedBenefits
                                .map((benefit) => benefit.name)
                                .join(', '),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                CustomTextField(
                  isMoney: true,
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
                  isMoney: true,
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
                  height: heightBetweenFields * 2,
                ),
                CompensationDropdownList(
                  title: 'Compensation',
                  onChanged: (value) {
                    setState(() {
                      selectedCompensation = value;
                    });
                  },
                  selectedItem: selectedCompensation,
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                CustomTextField(
                  action: TextInputAction.done,
                  controller: workHoursController,
                  label: "Work Hours",
                  onlyNumber: false,
                  hintText: 'Example: 8 hours',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                CustomTextField(
                  action: TextInputAction.done,
                  controller: experienceYearsController,
                  label: "Experience Years",
                  onlyNumber: false,
                  hintText: 'Example: 2 years',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                BlocBuilder<WorkFieldsBloc, WorkFieldsState>(
                  builder: (context, state) {
                    if (state is WorkFieldsInitial) {
                      return ShimmerLoader(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.4,
                      );
                    }
                    else if(state is WorkFieldsDoneState){
                      return SearchableDropDownWidget(
                        items: state.workFields,
                        selectedItem: _selectedWorkField,
                        onSelect: _handleSelectedWorkField,
                        title: 'Work Field',
                      );
                    }
                    else{return const SizedBox();}
                  }
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                JobTypeDropdownList(
                  title: 'Job Type',
                  onChanged: (value) {
                    setState(() {
                      selectedJobType = value;
                    });
                  },
                  selectedItem: selectedJobType,
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                DescriptionField(
                  maxLines: 10,
                  action: TextInputAction.done,
                  controller: descriptionController,
                  label: "Description",
                  onlyNumber: false,
                  hintText: 'Describe your vacancy with a few words',
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),

                const Text(
                  'Preferred Gender',
                  style: AppFontStyles.mediumH5,
                ),
                PreferredGenderWidget(
                    selectedPreferredGender: selectedGender,
                    onUserTypeSelected: (value) {
                      setState(() {
                        selectedGender = value ?? GenderEnum.none;
                      });
                    }),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                ElevatedButtonWidget(
                  gradientColor: AppColors.kDarkLinearColor,
                  title: "Get Expected Salary",
                  onPressed: () {
                    print(minimumSalaryController.text.replaceAll(",", ""));
                  },
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                BlocBuilder<AddJobBloc, AddJobState>(
                  builder: (context, state) {
                    return ElevatedButtonWidget(
                      isLoading: state is AddJobLoadingState,
                      title: "Submit",
                      onPressed: () {
                        if (!_key.currentState!.validate() &&
                            selectedDate != null && selectedJobType != null
                        && _selectedWorkField != null
                        ) {
                          return;
                        }
                        context.read<AddJobBloc>().add(
                              AddNewJobEvent(
                                position: positionController.text,
                                description: descriptionController.text,
                                startDate: selectedDate.toString(),
                                compensation: selectedCompensation!,
                                genderEnum: selectedGender,
                                maxSalary: num.tryParse(
                                        maximumSalaryController.text.replaceAll(",", "")) ??
                                    0,
                                minSalary: num.tryParse(
                                    minimumSalaryController.text.replaceAll(",", "")) ??
                                    0,
                                workHours: int.parse(workHoursController.text),
                                jobTypes: selectedJobType!,
                                experienceYears: int.parse(experienceYearsController.text),
                                workFieldId: _selectedWorkField!.id,
                                //  benefits: [1],
                                benefits: _selectedBenefits
                                    .map((benefit) => benefit.id)
                                    .toList(),
                              ),
                            );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
