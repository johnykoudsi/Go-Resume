import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/benefits_entity.dart';

import '../../../../utility/app_strings.dart';

class BenefitsScreen extends StatefulWidget {
  final void Function(List<BenefitEntity>)? onSelectionChanged;
  final List<BenefitEntity> benefits;
  final List<BenefitEntity> initiallySelectedItems;

  const BenefitsScreen({
    Key? key,
    this.onSelectionChanged,
    required this.benefits,
    required this.initiallySelectedItems,
  }) : super(key: key);

  @override
  _BenefitsScreenState createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  List<BenefitEntity> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initiallySelectedItems); // Initialize with initially selected items
  }

  void _toggleSelection(BenefitEntity item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    if (widget.onSelectionChanged != null) {
      widget.onSelectionChanged!(_selectedItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Text(AppStrings.benefits,style: AppFontStyles.boldH3,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 20,
          ),
          itemCount: widget.benefits.length,
          itemBuilder: (BuildContext context, int index) {
            BenefitEntity item = widget.benefits[index];
            return GestureDetector(
              onTap: () => _toggleSelection(item),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Material(
                  elevation: 5,
                  borderRadius: AppBorders.k24BorderRadius,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _selectedItems.contains(item)
                          ? AppColors.kGreyColor
                          : AppColors.kWhiteColor,
                      borderRadius: AppBorders.k24BorderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.name,
                        style: AppFontStyles.mediumH4,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
