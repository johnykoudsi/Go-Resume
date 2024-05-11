import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onOperationPressed;
  final bool visitor;
  const CustomCard({
    Key? key,
    required this.title,
    required this.content,
    this.onOperationPressed,
    this.visitor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppFontStyles.boldH5,
                  ),
                  if(!visitor)
                  TextButton(
                    onPressed: onOperationPressed,
                    child: Text(
                      "Manage",
                      style: AppFontStyles.boldH6.copyWith(color: Colors.red),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenSize.height * 0.02),
              Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: content,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
