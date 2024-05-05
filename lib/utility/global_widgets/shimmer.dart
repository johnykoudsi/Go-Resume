import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';

class ShimmerLoader extends StatelessWidget {
  final double? height;
  final double? width;
  BorderRadiusGeometry? border;

  ShimmerLoader({Key? key, this.height = 120, this.width = 50,this.border = AppBorders.k15BorderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: border,
          ),
          height: height,
          width: width,
        ));
  }
}
