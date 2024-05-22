import 'package:flutter/material.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/widget/searchable_city_widget.dart';
import '../../domain/entities/City_entity.dart';
import '../../domain/entities/country_entity.dart';
import 'searchable_country_widget.dart';

class CountryCityDropDown extends StatefulWidget {
  final List<Country> countries; // List of dropdown options
  final List<City> cities; // List of dropdown options
  final Country? selectedCountry; // Pre-selected item (optional)
  final City? selectedCity; // Pre-selected item (optional)
  final Function(Country) onCountrySelect;
  final Function(City) onCitySelect;
  final String title;
   bool cityLoading=false;
   CountryCityDropDown({
     required this.cityLoading,
     required this.title, required this.countries, this.selectedCountry, required this.onCountrySelect, required this.cities, this.selectedCity, required this.onCitySelect,
   } );

  @override
  State<CountryCityDropDown> createState() => _CountryCityDropDownState();
}

class _CountryCityDropDownState extends State<CountryCityDropDown> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
      SearchableCountryWidget(
      items: widget.countries,
      selectedItem: widget.selectedCountry,
      onSelect: widget.onCountrySelect,
      title: 'Country',
    ),
        widget.selectedCountry == null ?
            SizedBox.shrink():
            widget.cityLoading?
                CircularProgressIndicator():
        SearchableCityWidget(
          items: widget.cities,
          selectedItem: widget.selectedCity,
          onSelect: widget.onCitySelect,
          title: 'City',
        ),
      ],
    );
  }
}
