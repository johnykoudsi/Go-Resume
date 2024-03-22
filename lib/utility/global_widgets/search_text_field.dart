import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_recruitment_core/utility/theme/color_style.dart';

class SearchTextField extends StatelessWidget {
  SearchTextField({
    required this.onClear,
    required this.onSend,
    required this.searchController,
    required this.showSearchDeleteIcon,
    Key? key}) : super(key: key);
  Function()? onClear;
  Function(String?) onSend;
  TextEditingController searchController;
  bool showSearchDeleteIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16,vertical: 16),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: searchController,
              onFieldSubmitted: onSend,
              style: const TextStyle(
                  color: AppColors.kTextFieldGrey
              ),
              keyboardType: TextInputType.name,
              cursorColor: AppColors.kTextFieldGrey,
              decoration: InputDecoration(
                hintText: 'Search'.tr(),
                // hintStyle: TextStyle(
                //     color: kGreyColor,
                //     fontFamily: kNormalFont,
                //     fontSize: 4 * SizeConfig.blockSizeHorizontal),
                contentPadding:
                const EdgeInsets.only(
                    left: 15,
                    bottom: 0,
                    top: 0,
                    right: 15),
                suffixIcon: showSearchDeleteIcon
                    ? GestureDetector(
                  onTap:onClear,
                  child: const Icon(
                    Icons.cancel_rounded,
                    color: AppColors.redColor,
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus
                        ?.unfocus();
                    onSend(searchController.text);
                  },
                  child: const Icon(
                    Icons.search,
                    color:
                    AppColors.kGreyColor,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    )),
                disabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      width: 2,
                      color: AppColors.kMainColor100,
                    )),
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(7),
                    borderSide: const BorderSide(
                      color: AppColors.kMainColor100,
                    )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
