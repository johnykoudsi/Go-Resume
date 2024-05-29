import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/preferred_gender_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../domain/entities/City_entity.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/company_profile_bloc/company_profile_bloc.dart';
import '../widget/country_city_drop_down.dart';

class EditCompanyProfileScreen extends StatefulWidget {
  const EditCompanyProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditCompanyProfileScreen> createState() =>
      _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  GenderEnum? _selectedUserGender = GenderEnum.m;
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController visionController = TextEditingController();
  TextEditingController missionController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    context.read<GetAllCountriesBloc>().add(GetCountriesEvent());
    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      nameController.text = userBloc.user.data.fullName;
      aboutController.text = userBloc.user.data.company?.about ?? "";
      visionController.text = userBloc.user.data.company?.vision ?? "";
      missionController.text = userBloc.user.data.company?.mission ?? "";
      facebookController.text = userBloc.user.data.facebook;
      instagramController.text = userBloc.user.data.instagram;
      linkedinController.text = userBloc.user.data.linkedin;
      websiteController.text = userBloc.user.data.websiteLink;
      websiteController.text = userBloc.user.data.email;
    }
    super.initState();
  }
  Country? _selectedCountry;
  City? _selectedCity;

  void _handleSelectedCountries(Country selectedCountry) {
    context.read<GetAllCitiesBloc>().add(GetCitiesEvent(countryCode: selectedCountry.countryCode));
    setState(() {
      _selectedCountry = selectedCountry;
    });
  }

  void _handleSelectedCities(City selectedCities) {
    setState(() {
      _selectedCity = selectedCities;
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double heightBetweenFields = screenHeight * 0.015;
    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listener: (context, state) {
        if (state is CompanyProfileResponseState) {
          DialogsWidgetsSnackBar.showSnackBarFromStatus(
            context: context,
            helperResponse: state.helperResponse,
            showServerError: true,
            popOnSuccess: true,
          );
          if (state.helperResponse.servicesResponse ==
              ServicesResponseStatues.success) {
            context.read<UserBloc>().add(RefreshUserEvent());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:  Text(
            AppStrings.editProfile,
            style: AppFontStyles.boldH2,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
              screenWidth * 0.04, screenWidth * 0.03),
          children: [
            CustomTextField(
              action: TextInputAction.done,
              controller: nameController,
              label: "Name",
              onlyNumber: false,
              hintText: 'ESoft',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            BlocBuilder<GetAllCountriesBloc, GetAllCountriesState>(
              builder: (countryContext, countryState) {
                    if(countryState is GetAllCountriesInitial){
                      return ShimmerLoader(
                        height: screenHeight * 0.05,
                        width: screenWidth,
                      );
                    }
                    if(countryState is GetCountriesDoneState){
                      return
                        CountryCityDropDown(
                          title: '',
                          countries: countryState.countries,
                          onCountrySelect: _handleSelectedCountries,
                          onCitySelect: _handleSelectedCities,
                        );
                    }
                    else{return SizedBox.shrink();}
              },
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: emailController,
              label: "Email",
              onlyNumber: false,
              hintText: 'company@gmail.com',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: linkedinController,
              label: "LinkedIn",
              onlyNumber: false,
              hintText: 'https://www.linkedin.com/company',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: websiteController,
              label: "Website",
              onlyNumber: false,
              hintText: 'https://www.companywebsite.com',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: instagramController,
              label: "Instagram",
              onlyNumber: false,
              hintText: 'https://www.instagram.com/company',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            CustomTextField(
              action: TextInputAction.done,
              controller: facebookController,
              label: "Facebook",
              onlyNumber: false,
              hintText: 'https://www.facebook.com/company',
              textInputType: TextInputType.visiblePassword,
              passwordBool: false,
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: aboutController,
              label: "About",
              onlyNumber: false,
              hintText: 'Describe your company with a few words',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: visionController,
              label: "Vision",
              onlyNumber: false,
              hintText: 'Describe your company goals',
            ),
            SizedBox(
              height: heightBetweenFields,
            ),
            DescriptionField(
              action: TextInputAction.done,
              controller: missionController,
              label: "Mission",
              onlyNumber: false,
              hintText: 'Describe your company methods',
            ),
            // BlocBuilder<GetAllCountriesBloc, GetAllCountriesState>(
            //     builder: (context, state) {
            //       if (state is Coun) {
            //         return ShimmerLoader(
            //           height: screenHeight * 0.05,
            //           width: screenWidth * 0.4,
            //         );
            //       }
            //       else if(state is WorkFieldsDoneState){
            //         return SearchableDropDownWidget(
            //           items: state.workFields,
            //           selectedItem: _selectedWorkField,
            //           onSelect: _handleSelectedWorkField,
            //           title: 'Work Field',
            //         );
            //       }
            //       else{return const SizedBox();}
            //     }
            // ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
              builder: (context, state) {
                return ElevatedButtonWidget(
                  title: "Edit",
                  isLoading: state is CompanyProfileLoading,
                  onPressed: () {
                    context.read<CompanyProfileBloc>().add(
                        UpdateCompanyProfileEvent(
                            fullName: nameController.text,
                            websiteLink: websiteController.text,
                            instagram: instagramController.text,
                            facebook: facebookController.text,
                            linkedin: linkedinController.text,
                            email: emailController.text,
                            about: aboutController.text,
                            vision: visionController.text,
                            mission: missionController.text));
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
