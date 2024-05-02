import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class NotificationWidget extends StatelessWidget {
  final String imagePath;
  final String notificationTitle;
  final String notificationDetails;
  final String notificationDate;
  const NotificationWidget({Key? key,
    required this.imagePath,
    required this.notificationTitle,
    required this.notificationDetails,
    required this.notificationDate

  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.only(top: screenHeight*0.05),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ), // Replace with your profile image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notificationTitle,
                style: AppFontStyles.boldH6,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.5),
                child: Text(
                  notificationDetails,
                  style: AppFontStyles.mediumH6
                      .copyWith(color: AppColors.kGreyColor),
                  softWrap: true,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            notificationDate,
            style: AppFontStyles.mediumH6.copyWith(color: AppColors.kGreyColor),
          ),
          SizedBox(
            width: screenWidth * 0.02,
          ),
        ],
      ),
    );
  }
}
