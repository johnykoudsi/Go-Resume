import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_snackBar.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../bloc/policies_actions_bloc/policies_actions_bloc.dart';


class AddPolicyScreen extends StatefulWidget {
  const AddPolicyScreen({Key? key}) : super(key: key);

  @override
  State<AddPolicyScreen> createState() => _AddPolicyScreenState();
}

class _AddPolicyScreenState extends State<AddPolicyScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return BlocListener<PoliciesActionsBloc, PoliciesActionsState>(
      listener: (context, state) {
        if (state is PoliciesActionsResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: true,
            popOnSuccessCount: 2,
          );
          if (state.helperResponse.servicesResponse ==
              ServicesResponseStatues.success) {
            context.read<UserBloc>().add(RefreshUserEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Policy",
            style: AppFontStyles.boldH3,
          ),
        ),
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
                screenWidth * 0.04, screenWidth * 0.03),
            children: [
              CustomTextField(
                action: TextInputAction.done,
                controller: titleController,
                label: "title*",
                onlyNumber: false,
                hintText: 'Example: No smoking',
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "title is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: descriptionController,
                label: "Description*",
                onlyNumber: false,
                hintText: 'Example: Smoking is not allowed',
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "description is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.1),
          child: BlocBuilder<PoliciesActionsBloc, PoliciesActionsState>(
            builder: (context, state) {
              return ElevatedButtonWidget(
                title: "Add",
                isLoading: state is PoliciesActionsLoadingState,
                onPressed: () {
                    if (_key.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      context.read<PoliciesActionsBloc>().add(
                          AddPolicyEvent(
                              title: titleController.text,
                              description: descriptionController.text
                          ));
                    }

                },
              );
            },
          ),
        ),
      ),
    );
  }
}
