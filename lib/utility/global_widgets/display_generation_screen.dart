import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget_border.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_experineces/presentation/bloc/experience_generation/experience_generation_bloc.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';

class DisplayGenerationScreenArguments {
  final Object event;
  final String generation;
  DisplayGenerationScreenArguments(
      {required this.event, required this.generation});
}

class DisplayGenerationScreen extends StatefulWidget {
  const DisplayGenerationScreen({required this.arguments, super.key});
  final DisplayGenerationScreenArguments arguments;
  @override
  State<DisplayGenerationScreen> createState() =>
      _DisplayGenerationScreenState();
}

class _DisplayGenerationScreenState extends State<DisplayGenerationScreen> {
  String appBar = "";
  ScrollController scrollController = ScrollController();
  bool repeatAnimation = true;
  @override
  void initState() {
    final event = widget.arguments.event;
    if (event is PostExperienceGenerationEvent) {
      appBar = "Generated Experience";
    }
    if (event is PostEducationGenerationEvent) {
      appBar = "Generated Education";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBar,
          style: AppFontStyles.boldH3,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset(Assets.jsonJobDone, repeat: repeatAnimation),
          ),
          const SizedBox(
            height: 30,
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                widget.arguments.generation,
                textStyle: AppFontStyles.regularH3,
              ),
            ],
            onFinished: () {
              setState(() {
                repeatAnimation = false;
              });
            },
            onTap: () {
              setState(() {
                repeatAnimation = false;
              });
            },
            repeatForever: false,
            totalRepeatCount: 1,
            displayFullTextOnTap: true,
            // stopPauseOnTap: true,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButtonBorderWidget(
                    title: "Back",
                    mainColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButtonWidget(
                    title: "Proceed",
                    onPressed: () {
                      Navigator.of(context).pop();
                      final event = widget.arguments.event;
                      String route = AppRoutes.addExperience;
                      if (event is PostEducationGenerationEvent) {
                        route = AppRoutes.addEducation;
                      }
                      Navigator.of(context).pushReplacementNamed(
                        route,
                        arguments: widget.arguments,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
