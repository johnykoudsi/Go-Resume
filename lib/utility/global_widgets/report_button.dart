import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget_border.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/report/presentation/bloc/report_user_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/report_category_drop_down.dart';

import 'dialog_snack_bar.dart';

class ReportButton extends StatefulWidget {
  int id;
  ReportButton({
    required this.id,
    super.key,
  });

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  ReportUserBloc reportUserBloc = ReportUserBloc();
  ReportCategory? selectedCategory;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.canPop) {
      return BlocProvider.value(
        value: reportUserBloc,
        child: BlocConsumer<ReportUserBloc, ReportUserState>(
          listener: (context, state) {
            if (state is ReportUserDoneState) {
              DialogsWidgetsSnackBar.showSnackBarFromStatus(
                context: context,
                helperResponse: state.helperResponse,
                popOnSuccess: false,
              );
            }
          },
          builder: (context, state) {
            if (state is ReportUserLoadingState) {
              return const SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.all(14),
                child: IconButton(
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                  icon: const Icon(
                    Icons.report_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return const SizedBox(
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.height;

        return BlocProvider.value(
          value: reportUserBloc,
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(15),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.01,
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: AppBorders.k15BorderRadius,
                    color: AppColors.kBackGroundColor),
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.038,
                    screenWidth * 0.1,
                    screenWidth * 0.038,
                    screenWidth * 0.038),
                child: Wrap(
                  spacing: 10,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ReportCategoryDropDown(
                            title: "category".tr(),
                            selectedItem: selectedCategory,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                                Navigator.of(context)
                                    .pop(); // Close the dialog after selection
                                _showConfirmationDialog(
                                    context); // Re-open the dialog with updated value
                              });
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          DescriptionField(
                            action: TextInputAction.done,
                            controller: descriptionController,
                            label: "description".tr(),
                            onlyNumber: false,
                            hintText: "reportDescription".tr(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.05),
                    Builder(builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: ElevatedButtonBorderWidget(
                              title: "cancel".tr(),
                              mainColor: AppColors.kGreyColor,
                              gradientColor: AppColors.kDarkLinearColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.038,
                          ),
                          Expanded(
                            child: BlocBuilder<ReportUserBloc, ReportUserState>(
                              builder: (context, state) {
                                return ElevatedButtonWidget(
                                    title: "report".tr(),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.read<ReportUserBloc>().add(
                                          ReportUserApiEvent(
                                              id: widget.id,
                                              description:
                                                  descriptionController.text ??
                                                      "",
                                              category: selectedCategory));
                                    });
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
