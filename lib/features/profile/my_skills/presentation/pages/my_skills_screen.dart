import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/skill.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/dialogs_and_snackbars/dialogs_snackBar.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/shimmer.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/profile/applicant_profile/presentation/widgets/skill_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/bloc/get_skills_bloc/get_skills_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/bloc/skill_actions_bloc/skill_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_skills/presentation/widget/all_skills_drop_down.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';

import '../../../../../utility/app_strings.dart';

class MySkillsScreen extends StatefulWidget {
  const MySkillsScreen({required this.skills, Key? key}) : super(key: key);
  final List<Skill> skills;
  @override
  State<MySkillsScreen> createState() => _MySkillsScreenState();
}

class _MySkillsScreenState extends State<MySkillsScreen> {
  List<Skill> currentSkills = [];
  @override
  void initState() {
    currentSkills = widget.skills.map((skill) => skill.copyWith()).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetSkillsBloc()..add(const GetAllSkillsEvent()),
        ),
        BlocProvider(
          create: (context) => SkillActionsBloc(),
        ),
      ],
      child: BlocListener<SkillActionsBloc, SkillActionsState>(
        listener: (context, state) {
          if (state is SkillActionsResponseState) {
            DialogsWidgetsSnackBar.showSnackBarFromStatus(
                context: context, helperResponse: state.helperResponse);
            if (state.helperResponse.servicesResponse ==
                ServicesResponseStatues.success) {
              context.read<UserBloc>().add(RefreshUserEvent());
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title:  Text(
              AppStrings.mySkills,
              style: AppFontStyles.boldH2,
            ),
            iconTheme:
                const IconThemeData(size: 25, color: AppColors.fontColor),
          ),
          body:
          currentSkills.isEmpty?
               const NoDataWidget()
              :
          ListView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: currentSkills.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.02),
                child: SkillWidget(
                  skill: currentSkills[index],
                  showDelete: true,
                  onDeletePressed: (skill) {
                    setState(() {
                      currentSkills
                          .removeWhere((element) => skill.id == element.id);
                    });
                  },
                ),
              );
            },
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<GetSkillsBloc, GetSkillsState>(
                  builder: (context, state) {
                    if (state is GetSkillsLoadedState) {
                      return SkillDropdownList(
                        title: AppStrings.selectNewSkill,
                        selectedItem: currentSkills.isNotEmpty
                            ? currentSkills.last
                            : null,
                        allSkills: state.skills,
                        onChanged: (value) {
                          setState(() {
                            int index = currentSkills.indexWhere(
                                (element) => element.id == value.id);
                            if (index == -1) {
                              currentSkills.add(value);
                            } else {
                              DialogsWidgetsSnackBar.showScaffoldSnackBar(
                                  title: AppStrings.skillAlreadyAdded,
                                  context: context);
                            }
                          });
                        },
                      );
                    }
                    return AppShimmerLoader(
                      height: 50,
                      width: 5000,
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocBuilder<SkillActionsBloc, SkillActionsState>(
                  builder: (context, state) {
                    return ElevatedButtonWidget(
                      title: AppStrings.saveSkills,
                      isLoading: state is SkillActionsLoadingState,
                      onPressed: () {
                        context
                            .read<SkillActionsBloc>()
                            .add(AddSkillEvent(skills: currentSkills));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
