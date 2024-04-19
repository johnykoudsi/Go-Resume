import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/app_borders.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';

class SearchableDropDownWidget extends StatefulWidget {
  final List<String> items; // List of dropdown options
  final String selectedItem; // Pre-selected item (optional)
  final Function onSelect;
  final String title;// Callback function for selection

  const SearchableDropDownWidget(
      {required this.items,
      required this.selectedItem,
      required this.onSelect, required this.title});

  @override
  _SearchableDropDownWidgetState createState() =>
      _SearchableDropDownWidgetState();
}

class _SearchableDropDownWidgetState extends State<SearchableDropDownWidget> {

  final ScrollController _scrollController = ScrollController();
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

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
        child: DropdownButton2<String>(
          iconStyleData: const IconStyleData(
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black
          ),
          isExpanded: true,
          hint:  Text(
            widget.title,
              style: AppFontStyles.mediumH3,
          ),
          items: widget.items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item, style: AppFontStyles.mediumH3,
      
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
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
                onTap: (){
                  _scrollController.animateTo(100, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                },
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
      
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
              return item.value.toString().contains(searchValue);
            },
          ),
          //This to clear the search value when you close the menu
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
