import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../generated/assets.dart';


class EmployeeOnRoad extends StatelessWidget {
  const EmployeeOnRoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Image.asset(
        Assets.pngEmployeeOnRoad,
        width: screenWidth,
        // height: screenHeight*0.9,
      ),
    );
  }
}
