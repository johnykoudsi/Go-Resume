import 'package:flutter/material.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/widget/searchable_city_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';
import '../../domain/entities/City_entity.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/get_all_cities/get_all_cities_bloc.dart';
import 'searchable_country_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCityDropDown extends StatefulWidget {
  final List<Country> countries; // List of dropdown options
  final Country? selectedCountry; // Pre-selected item (optional)
  final City? selectedCity; // Pre-selected item (optional)
  final Function(Country) onCountrySelect;
  final Function(City) onCitySelect;
  final String title;
  CountryCityDropDown({
    required this.title,
    required this.countries,
    this.selectedCountry,
    required this.onCountrySelect,
    required this.onCitySelect, this.selectedCity,
  });

  @override
  State<CountryCityDropDown> createState() => _CountryCityDropDownState();
}

class _CountryCityDropDownState extends State<CountryCityDropDown> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return Column(
      children: [
        SearchableCountryWidget(
          items: widget.countries,
          selectedItem: widget.selectedCountry,
          onSelect: widget.onCountrySelect,
          title: 'Country',
        ),
        SizedBox(height: heightBetweenFields,),
        BlocBuilder<GetAllCitiesBloc, GetAllCitiesState>(
          builder: (cityContext, cityState) {
            if(cityState is GetAllCitiesInitial){
            return  SizedBox.shrink();
            }
            if(cityState is GetCitiesLoadingState){
             return ShimmerLoader(
               height: screenHeight * 0.05,
               width: screenWidth,
             );
            }
            if(cityState  is GetCitiesDoneState){
              return SearchableCityWidget(
                items: cityState.cities,
                selectedItem: widget.selectedCity,
                onSelect: widget.onCitySelect,
                title: 'City',
              );
            }else{return SizedBox.shrink();}
          },
        ),
      ],
    );
  }
}
