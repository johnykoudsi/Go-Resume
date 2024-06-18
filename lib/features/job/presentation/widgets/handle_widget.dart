import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';


class HandleWidget extends StatelessWidget {
  const HandleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 8),
      child: Center(
        child: Container(
          width: 100,
          //margin: const EdgeInsets.all(8),
          height: 5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppBorders.k4BorderRadius,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
