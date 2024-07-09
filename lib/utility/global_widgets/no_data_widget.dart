
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

import '../../generated/assets.dart';
import '../app_strings.dart';

class NoDataWidget extends StatefulWidget {
  final bool? small;
   const NoDataWidget({Key? key,
       this.small=false,
    }) : super(key: key);


  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:   EdgeInsets.only(bottom: widget.small == true ?0:screenHeight*0.2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                Assets.jsonNoDataWidget,
                repeat: false,
                height:widget.small==true?screenHeight*0.2: screenHeight*0.3
            ),
            Text("noData".tr(),style: AppFontStyles.mediumH3,)
          ],
        ),
      ),
    );
  }
}