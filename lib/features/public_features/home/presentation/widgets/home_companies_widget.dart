import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/get_user_features/widgets/company_widget.dart';

class HomeCompaniesSectionWidget extends StatelessWidget {
  const HomeCompaniesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Companies",
                  style: AppFontStyles.mediumH3.copyWith(fontSize: 22),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
                      style: AppFontStyles.mediumH5
                          .copyWith(color: AppColors.kMainColor100),
                    ))
              ]),
        ),
        AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return const CompanyWidget();
          },
        ),
      ],
    );
  }
}
