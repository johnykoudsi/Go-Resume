import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/domain/entities/benefits_entity.dart';

class BenefitsScreen extends StatefulWidget {
  final List<String>? items;
  final void Function(List<String>)? onSelectionChanged;
  final List<String>? initiallySelectedItems;
  final List<BenefitEntity>benefits;


  const BenefitsScreen({Key? key,  this.items,  this.onSelectionChanged,  this.initiallySelectedItems, required this.benefits}) : super(key: key);

  @override
  _BenefitsScreenState createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    //_selectedItems = List.from(widget.benefits);
  }

  void _toggleSelection(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });

    // Call the callback function with the updated selected items
  //  widget.onSelectionChanged!(_selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benefits'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: widget.benefits.length,
        itemBuilder: (BuildContext context, int index) {
          String item = widget.benefits[index].name;
          return GestureDetector(
            onTap: () => _toggleSelection(item),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Material(
                elevation: 5,
                borderRadius: AppBorders.k24BorderRadius,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _selectedItems.contains(item) ? AppColors.kGreyColor : AppColors.kWhiteColor,
                    borderRadius: AppBorders.k24BorderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item,
                      style: AppFontStyles.mediumH4,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
