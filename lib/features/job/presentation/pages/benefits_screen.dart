import 'package:easy_localization/easy_localization.dart';
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
bool isOn(BenefitEntity item){
    if(searchBenefitsList(item, _selectedItems)){
      return true;
    }else{
      return false;
    }
}
  void _toggleSelection(BenefitEntity item) {
    setState(() {
      if (searchBenefitsList(item, _selectedItems)) {
        removeBenefit(item,_selectedItems);

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
        title:   Text("benefits".tr(),style: AppFontStyles.boldH3,),
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
                  elevation: 8, // Enhanced elevation for a more prominent shadow
                  shadowColor: Colors.black45, // Subtle shadow color
                  borderRadius: AppBorders.k24BorderRadius,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient( // Subtle gradient for the background
                        colors: [
                          AppColors.kWhiteColor,
                          searchBenefitsList(item, _selectedItems)
                              ? Colors.grey
                              : AppColors.kWhiteColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: AppBorders.k24BorderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0), // Consistent padding around the content
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.name, // Display the benefit name
                                  style: AppFontStyles.boldH3.copyWith(
                                    color: AppColors.fontColor, // Custom color for the name
                                    fontWeight: FontWeight.w600, // Slightly heavier font weight
                                  ),
                                  overflow: TextOverflow.visible, // Handle overflow gracefully
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.check_circle, // Add an icon (optional)
                                  color: isOn(item) ? AppColors.fontColor : AppColors.kGreyColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0), // Spacing between name and description
                          Flexible(
                            child: Text(
                              item.description, // Display the benefit description
                              style: AppFontStyles.mediumH4.copyWith(
                                color: isOn(item) ? AppColors.kTextField2Grey : AppColors.kGreyColor, // Custom color for the description
                                fontStyle: FontStyle.italic, // Italic for description
                              ),
                              overflow: TextOverflow.clip, // Handles text overflow for long descriptions
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )



            );
          },
        ),
      ),
    );
  }

   searchBenefitsList(BenefitEntity item, List<BenefitEntity> selectedItems) {
    for(int i=0;i<selectedItems.length;i++){
      if(item.id==selectedItems[i].id){
        return true;
      }
    }return false;
  }

  void removeBenefit(BenefitEntity item, List<BenefitEntity> selectedItems) {
    for(int i=0;i<selectedItems.length;i++){
      if(item.id==selectedItems[i].id){
       _selectedItems.remove(_selectedItems[i]);
      }
    }
  }


}
