import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';
import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/global_widgets/custom_text_field.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/theme/text_styles.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/core/router/app_routes.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/date_picker_widget.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/description_field.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/preferred_gender_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/custom_floating_button_widget.dart';
import '../../../../../utility/app_strings.dart';
import '../../../../../utility/global_widgets/dialog_snack_bar.dart';
import '../../../../../utility/global_widgets/display_generation_screen.dart';
import '../../../../../utility/global_widgets/shimmer.dart';
import '../../../company_profile/domain/entities/City_entity.dart';
import '../../../company_profile/domain/entities/country_entity.dart';
import '../../../company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import '../../../company_profile/presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import '../../../company_profile/presentation/widget/country_city_drop_down.dart';
import '../bloc/applicant_profile_bloc.dart';

class EditApplicantProfileScreen extends StatefulWidget {
  const EditApplicantProfileScreen({this.arguments, Key? key})
      : super(key: key);
  final DisplayGenerationScreenArguments? arguments;
  @override
  State<EditApplicantProfileScreen> createState() =>
      _EditApplicantProfileScreenState();
}

class _EditApplicantProfileScreenState
    extends State<EditApplicantProfileScreen> {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  GenderEnum? _selectedUserGender = GenderEnum.m;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    print(widget.arguments?.generation);

    context.read<GetAllCountriesBloc>().add(GetCountriesEvent());

    final userBloc = context.read<UserBloc>().state;
    if (userBloc is UserLoggedState) {
      nameController.text = userBloc.user.data.fullName;
      bioController.text = widget.arguments?.generation ??
          userBloc.user.data.applicant?.bio ??
          "";
      selectedDate = userBloc.user.data.applicant?.dob;
      _selectedUserGender = userBloc.user.data.applicant?.gender == "m"
          ? GenderEnum.m
          : userBloc.user.data.applicant?.gender == "f"
              ? GenderEnum.f
              : GenderEnum.none;
      facebookController.text = userBloc.user.data.facebook;
      instagramController.text = userBloc.user.data.instagram;
      linkedinController.text = userBloc.user.data.linkedin;
      websiteController.text = userBloc.user.data.websiteLink;
      emailController.text = userBloc.user.data.email;
    }
    super.initState();
  }

  Country? _selectedCountry;
  City? _selectedCity;

  void _handleSelectedCountries(Country selectedCountry) {
    context
        .read<GetAllCitiesBloc>()
        .add(GetCitiesEvent(countryCode: selectedCountry.countryCode));
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
    return BlocListener<ApplicantProfileBloc, ApplicantProfileState>(
      listener: (context, state) {
        if (state is ApplicantProfileResponseState) {
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
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.04, screenWidth * 0.06,
                screenWidth * 0.04, screenWidth * 0.03),
            children: [
              CustomTextField(
                action: TextInputAction.done,
                controller: nameController,
                label: AppStrings.fullName+AppStrings.star,
                onlyNumber: false,
                hintText: AppStrings.johnDue,
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.fullName+AppStrings.isRequired;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              BlocBuilder<GetAllCountriesBloc, GetAllCountriesState>(
                builder: (countryContext, countryState) {
                  if (countryState is GetAllCountriesInitial) {
                    return ShimmerLoader(
                      height: screenHeight * 0.05,
                      width: screenWidth,
                    );
                  }
                  if (countryState is GetCountriesDoneState) {
                    return CountryCityDropDown(
                      title: '',
                      countries: countryState.countries,
                      onCountrySelect: _handleSelectedCountries,
                      onCitySelect: _handleSelectedCities,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: emailController,
                label: AppStrings.email,
                onlyNumber: false,
                hintText: 'example@gmail.com',
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
                hintText: 'https://www.linkedin.com/example',
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              CustomTextField(
                action: TextInputAction.done,
                controller: websiteController,
                label: AppStrings.website,
                onlyNumber: false,
                hintText: 'https://www.example.com',
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
                hintText: 'https://www.instagram.com/example',
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
                hintText: 'https://www.facebook.com/example',
                textInputType: TextInputType.visiblePassword,
                passwordBool: false,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DatePickerWidget(
                label: AppStrings.dob,
                selectedDate: selectedDate,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              DescriptionField(
                action: TextInputAction.done,
                controller: bioController,
                label: AppStrings.bio,
                onlyNumber: false,
                hintText: AppStrings.describeYourself,
              ),
              SizedBox(
                height: heightBetweenFields,
              ),
              PreferredGenderWidget(
                  selectedPreferredGender: _selectedUserGender,
                  onUserTypeSelected: (value) {
                    setState(() {
                      _selectedUserGender = value;
                    });
                  }),
              SizedBox(
                height: screenHeight * 0.1,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: BlocBuilder<ApplicantProfileBloc, ApplicantProfileState>(
                builder: (context, state) {
                  return ElevatedButtonWidget(
                    title: AppStrings.edit,
                    isLoading: state is ApplicantProfileLoading,
                    onPressed: () {
                      if (!_key.currentState!.validate()) {
                        return;
                      }
                      context
                          .read<ApplicantProfileBloc>()
                          .add(UpdateApplicantProfileEvent(
                            dob: selectedDate,
                            gender: _selectedUserGender ?? GenderEnum.none,
                            bio: bioController.text,
                            fullName: nameController.text,
                            websiteLink: websiteController.text,
                            instagram: instagramController.text,
                            facebook: facebookController.text,
                            linkedin: linkedinController.text,
                            email: emailController.text,
                        cityId: _selectedCity?.id.toString(),
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: CustomFloatingButtonWidget(
          icon: const Icon(Icons.auto_fix_high_rounded),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.bioAIGeneration);
          },
        ),
      ),
    );
  }
}
