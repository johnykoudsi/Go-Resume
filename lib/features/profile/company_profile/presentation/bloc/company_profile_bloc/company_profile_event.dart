part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  const CompanyProfileEvent();
}
class UpdateCompanyProfileEvent extends CompanyProfileEvent {
  UpdateCompanyProfileEvent({
    this.about,
    this.websiteLink,
    this.instagram,
    this.facebook,
    this.linkedin,
    this.email,
    this.fullName,
    this.vision,
    this.mission,
    this.culture
  });
  String? about;
  String? websiteLink;
  String? instagram;
  String? facebook;
  String? linkedin;
  String? email;
  String? fullName;
  String? culture;
  String? vision;
  String? mission;

  Map<String, dynamic> toJson() {
    final json = {
      "full_name": fullName,
      "website_link": websiteLink,
      "instagram": instagram,
      "facebook": facebook,
      "linkedin": linkedin,
      "email": email,
      "about":about,
      "culture":culture,
      "vision":vision,
      "mission":mission,
    };
    json.removeWhere(
            (key, value) => value == "" || value == null || value == "null");
    return json;
  }

  @override
  List<Object?> get props => [
    fullName,
    websiteLink,
    instagram,
    facebook,
    linkedin,
    email,
    about,
    culture,
    vision,
    mission
  ];
}