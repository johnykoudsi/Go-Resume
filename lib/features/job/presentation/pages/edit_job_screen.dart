import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget_border.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/work_field_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/edit_job/edit_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/salary_expectation/salary_expectation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/benefits_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/compensation_drop_down.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_drop_down.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/preferred_gender_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/app_strings.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../../utility/global_widgets/searchable_drop_down_widget.dart';
import '../../../../../utility/global_widgets/shimmer.dart';
import '../../domain/entities/benefits_entity.dart';
import '../bloc/work_fields/work_fields_bloc.dart';
import 'benefits_screen.dart';

class EditJobScreen extends StatefulWidget {
  const EditJobScreen({Key? key, required this.arguments,}) : super(key: key);
  final JobEntity arguments;

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
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
  int workFieldId=0;

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
     positionController.text = widget.arguments.position;
     descriptionController.text = widget.arguments.description;
     minimumSalaryController.text = widget.arguments.minSalary.toString();
     maximumSalaryController.text = widget.arguments.maxSalary.toString();
     workHoursController.text = widget.arguments.workHours.toString();
     experienceYearsController.text = widget.arguments.experienceYears.toString();

     selectedGender = widget.arguments.gender;
     selectedCompensation=widget.arguments.compensation;
     _selectedBenefits = widget.arguments.benefits;
     selectedDate=widget.arguments.startDate;
     selectedJobType=widget.arguments.type;

     workFieldId=widget.arguments.workFieldId;
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

    return BlocListener<EditJobBloc, EditJobState>(
      listener: (context, state) {
        if (state is EditJobResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            showServerError: true,
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: false,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:  Text(
            "editMyJob".tr(),
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
                  label: "${"position".tr()}*",
                  onlyNumber: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "position".tr() + "isRequired".tr();
                    }
                    return null;
                  },
                  hintText: "softwareEngineer".tr(),
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                DatePickerWidget(
                  maxDate: DateTime.now().add(const Duration(days: 360)),
                  label: "startDate".tr()+"star".tr(),
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
                            ? "addSomeBenefits".tr()
                            : _selectedBenefits
                            .map((benefit) => benefit.name)
                            .join(', '),
                      );
                    } else {
                      return const SizedBox.shrink();
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
                  label: "minimumSalary".tr()+"star".tr(),
                  onlyNumber: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "minimumSalary".tr()+"isRequired".tr();
                    }
                    return null;
                  },
                  hintText: '1000,000 ${"syp".tr()}',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                CustomTextField(
                  isMoney: true,
                  action: TextInputAction.done,
                  controller: maximumSalaryController,
                  label: "maximumSalary".tr()+"star".tr(),
                  onlyNumber: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "maximumSalary".tr()+"isRequired".tr();
                    }
                    return null;
                  },
                  hintText: '2000,000 ${"syp".tr()}',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                CompensationDropdownList(
                  title: "compensation".tr(),
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
                  label: "dailyWorkHours".tr(),
                  onlyNumber: true,
                  hintText: '8 ${"hours".tr()}',
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: heightBetweenFields,
                ),
                CustomTextField(
                  action: TextInputAction.done,
                  controller: experienceYearsController,
                  label: "experienceYears".tr(),
                  onlyNumber: true,
                  hintText: '2 ${"years".tr()}',
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
                      } else if (state is WorkFieldsDoneState) {
                        return SearchableDropDownWidget(
                          items: state.workFields,
                          selectedItem: state.workFields[workFieldId],
                          onSelect: _handleSelectedWorkField,
                          title: "workField".tr(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                JobTypeDropdownList(
                  title: "jobType".tr(),
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
                  label: "description".tr(),
                  onlyNumber: false,
                  hintText: "describeVacancy".tr(),
                ),
                SizedBox(
                  height: heightBetweenFields * 2,
                ),
                Text(
                  "preferredGender".tr(),
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
                BlocBuilder<EditJobBloc, EditJobState>(
                  builder: (context, state) {
                    return ElevatedButtonWidget(
                      isLoading: state is EditJobLoadingState,
                      title: "edit".tr(),
                      onPressed: () {
                        if (!_key.currentState!.validate() ||
                            selectedDate == null ||
                            selectedJobType == null ||
                            _selectedWorkField == null) {
                          return;
                        }
                        context.read<EditJobBloc>().add(
                          EditMyJobEvent(
                            jobId: widget.arguments.id,
                            position: positionController.text,
                            description: descriptionController.text,
                            startDate: selectedDate.toString(),
                            compensation: selectedCompensation!,
                            genderEnum: selectedGender,
                            maxSalary: num.tryParse(maximumSalaryController
                                .text
                                .replaceAll(",", "")) ??
                                0,
                            minSalary: num.tryParse(minimumSalaryController
                                .text
                                .replaceAll(",", "")) ??
                                0,
                            workHours: int.parse(workHoursController.text),
                            jobTypes: selectedJobType!,
                            experienceYears:
                            int.parse(experienceYearsController.text),
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
