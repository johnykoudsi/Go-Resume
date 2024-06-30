part of 'applicant_profile_bloc.dart';

abstract class ApplicantProfileEvent extends Equatable {
  const ApplicantProfileEvent();
}

class AddFcmToken extends ApplicantProfileEvent {
  @override
  List<Object?> get props => [];
}

class UpdateApplicantProfileEvent extends ApplicantProfileEvent {
  UpdateApplicantProfileEvent(
      {this.dob,
      this.gender,
      this.bio,
      this.fullName,
      this.websiteLink,
      this.instagram,
      this.facebook,
      this.linkedin,
      this.email,
      this.profileImage,
      this.coverImage,
      this.countryId,
      this.cityId});
  DateTime? dob;
  GenderEnum? gender;
  String? bio;
  String? fullName;
  String? websiteLink;
  String? instagram;
  String? facebook;
  String? linkedin;
  String? email;
  String? countryId;
  String? cityId;
  List<File>? profileImage;
  List<File>? coverImage;

  Map<String, String> toMapBody() {
    Map<String, String> map = {
      "dob": dob != null ? DateFormat('yyyy-MM-dd').format(dob!) : "",
      "gender": gender?.name ?? "",
      "bio": bio ?? "",
      "full_name": fullName ?? "",
      "website_link": websiteLink ?? "",
      "instagram": instagram ?? "",
      "facebook": facebook ?? "",
      "linkedin": linkedin ?? "",
      "email": email ?? "",
      "country_id": countryId ?? "",
      "city_id": cityId ?? "",
    };
    map.removeWhere(
        (key, value) => value == "" || value == null || value == "null");
    return map;
  }

  @override
  List<Object?> get props => [
        dob,
        gender,
        bio,
        fullName,
        websiteLink,
        instagram,
        facebook,
        linkedin,
        email,
        profileImage,
        coverImage,
        countryId,
        cityId
      ];
}
