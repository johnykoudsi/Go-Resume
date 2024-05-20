import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/policy.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_yes_no.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/shimmer.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_card.dart';
import '../../../../../utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../job/presentation/widgets/description_item_widget.dart';

class MyPoliciesScreen extends StatefulWidget {
  const MyPoliciesScreen({required this.policies, Key? key})
      : super(key: key);
  final List<Policy>? policies;
  @override
  State<MyPoliciesScreen> createState() => _MyPoliciesScreenState();
}

class _MyPoliciesScreenState extends State<MyPoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<PoliciesActionsBloc, PoliciesActionsState>(
      listener: (context, state) {
        if (state is PoliciesActionsResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            popOnSuccess: true,
          );
          if(state.helperResponse.servicesResponse == ServicesResponseStatues.success){
            context.read<UserBloc>().add(RefreshUserEvent());
          }        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Policies",
            style: AppFontStyles.boldH3,
          ),
          iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
        ),
        body: ListView.builder(
          itemCount: widget.policies != null ? widget.policies!.length:0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02),
              child: BlocBuilder<PoliciesActionsBloc, PoliciesActionsState>(
                builder: (context, state) {
                  if (state is PoliciesActionsLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AppShimmerLoader(),
                    );
                  }
                  return CustomCard(
                    onOperationPressed: () {
                      DialogsWidgetsYesNo.showYesNoDialog(
                        title: "Are you sure you want to delete this item.",
                        noTitle: "No",
                        yesTitle: "Yes",
                        isLoading: state is PoliciesActionsLoadingState,
                        onYesTap: () {
                          Navigator.of(context).pop();
                          context
                              .read<PoliciesActionsBloc>()
                              .add(DeletePolicyEvent(
                            id: widget.policies![index].id,
                          ));
                        },
                        onNoTap: () {
                          Navigator.of(context).pop();
                        },
                        context: context,
                      );
                    },
                    operation: "Delete",
                    title: "Policy",
                    content: DescriptionItemWidget(
                      description: widget.policies![index].description,
                    ),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const CustomFloatingButtonWidget(
              icon: Icon(Icons.auto_fix_high_rounded),
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            CustomFloatingButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addPolicy);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
