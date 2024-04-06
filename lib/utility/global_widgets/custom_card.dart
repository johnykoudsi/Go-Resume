import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String operation;
  final Widget content;
  final VoidCallback? onOperationPressed;

  const CustomCard({
    Key? key,
    required this.title,
    required this.operation,
    required this.content,
    this.onOperationPressed,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppFontStyles.boldH6,
                  ),
                  InkWell(
                    onTap: onOperationPressed,
                    child: Text(
                      operation,
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