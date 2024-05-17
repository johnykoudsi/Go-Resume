import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import '../../features/shared_features/job/domain/entities/work_field_entity.dart';

class SearchableDropDownWidget extends StatefulWidget {
  final List<WorkFieldEntity> items; // List of dropdown options
  final WorkFieldEntity? selectedItem; // Pre-selected item (optional)
  final Function(WorkFieldEntity) onSelect;
  final String title; // Title for the dropdown

  const SearchableDropDownWidget({
    required this.items,
    required this.selectedItem,
    required this.onSelect,
    required this.title,
  });

  @override
  _SearchableDropDownWidgetState createState() =>
      _SearchableDropDownWidgetState();
}

class _SearchableDropDownWidgetState extends State<SearchableDropDownWidget> {
  final ScrollController _scrollController = ScrollController();
  WorkFieldEntity? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<WorkFieldEntity>(
          iconStyleData: const IconStyleData(
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black,
          ),
          isExpanded: true,
          hint: Text(
            widget.title,
            style: AppFontStyles.mediumH5,
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<WorkFieldEntity>(
            value: item,
            child: Text(
              item.name,
              style: AppFontStyles.mediumH5,
            ),
          ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onSelect(value!);
          },
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.kGreyColor),
              borderRadius: AppBorders.k8BorderRadius,
            ),
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                onTap: () {
                  _scrollController.animateTo(100,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.kBackGroundColor),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value!.name.toLowerCase().contains(searchValue.toLowerCase());
            },
          ),
          // This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
