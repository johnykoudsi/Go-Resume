import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/features/my_submissions/presentation/bloc/my_submissions_bloc.dart';
import '../../../../../utility/global_widgets/shimmer.dart';
import '../../domain/entities/my_submissions_entity.dart';

class MySubmissionsScreen extends StatefulWidget {
  const MySubmissionsScreen({Key? key}) : super(key: key);

  @override
  State<MySubmissionsScreen> createState() => _MySubmissionsScreenState();
}

class _MySubmissionsScreenState extends State<MySubmissionsScreen> {
  ScrollController scrollController = ScrollController();
  MySubmissionsBloc mySubmissionsBloc = MySubmissionsBloc();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<MySubmissionsBloc>().add(
              GetMySubmissionsEvent(
                searchFilterProperties: SubmissionsSearchFilter(),
              ),
            );
      }
    });
    super.initState();
  }

  void search() {
    mySubmissionsBloc.add(ChangeToLoadingApiMySubmissionsEvent(
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Submissions",
          style: AppFontStyles.boldH2,
        ),
        iconTheme: const IconThemeData(size: 25, color: AppColors.fontColor),
      ),
      body: BlocBuilder<MySubmissionsBloc, MySubmissionsState>(
        builder: (context, state) {
          if(state is MySubmissionsLoadedState){
            return ListView.builder(
              padding: const EdgeInsets.all(18),
                controller: scrollController,
              itemCount: state.hasReachedMax
                  ? state.submissions.length
                  : state.submissions.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.submissions.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                          height: 130,
                          child: ShimmerLoader()),
                    );
                  }
                  return JobWidget(
                    jobEntity: state.submissions[index],
                  );
                }

            );

          } if(state is MySubmissionsInitial){
            return ListView.builder(
                padding: const EdgeInsets.all(18),

                controller: scrollController,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SizedBox(
                          height: 130,
                          child: ShimmerLoader()),
                    );
                }
            );

          }return SomethingWrongWidget(
            elevatedButtonWidget: ElevatedButtonWidget(
              title: "Refresh",
              onPressed: () {
                context.read<MySubmissionsBloc>().add(ChangeToLoadingApiMySubmissionsEvent());
                //search(userS);
              },
            ),
          );

        },
      ),
    );
  }
}
