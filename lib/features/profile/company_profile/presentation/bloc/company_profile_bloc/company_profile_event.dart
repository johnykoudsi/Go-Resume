part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  const CompanyProfileEvent();
}
class AddFcmToken extends CompanyProfileEvent {
  @override
  List<Object?> get props => [];
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
    this.culture,
    this.profileImage,
    this.coverImage,
    this.cityId
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
  String? cityId;
  List<File>? profileImage;
  List<File>? coverImage;

  Map<String, String> toMapBody() {

    Map<String, String> map = {
      "full_name": fullName??"",
      "website_link": websiteLink??"",
      "instagram": instagram??"",
      "facebook": facebook??"",
      "linkedin": linkedin??"",
      "email": email??"",
      "about":about??"",
      "culture":culture??"",
      "vision":vision??"",
      "mission":mission??"",
      "city_id":cityId??"",
    };
    map.removeWhere(
            (key, value) => value == "" || value == null || value == "null");
    return map;
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
    mission,
    profileImage,
    coverImage,
    cityId
  ];
}