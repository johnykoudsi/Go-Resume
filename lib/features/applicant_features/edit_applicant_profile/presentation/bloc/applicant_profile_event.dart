part of 'applicant_profile_bloc.dart';

abstract class ApplicantProfileEvent extends Equatable {
  const ApplicantProfileEvent();
}

class UpdateApplicantProfileEvent extends ApplicantProfileEvent {
  UpdateApplicantProfileEvent({
    this.dob,
    this.gender,
    this.bio,
    this.fullName,
    this.websiteLink,
    this.instagram,
    this.facebook,
    this.linkedin,
    this.email,
  });
  DateTime? dob;
  GenderEnum? gender;
  String? bio;
  String? fullName;
  String? websiteLink;
  String? instagram;
  String? facebook;
  String? linkedin;
  String? email;

  Map<String, dynamic> toJson() {
    final json = {
      "dob": dob != null ? DateFormat('yyyy-MM-dd').format(dob!) : null,
      "gender": gender?.name,
      "bio": bio,
      "full_name": fullName,
      "website_link": websiteLink,
      "instagram": instagram,
      "facebook": facebook,
      "linkedin": linkedin,
      "email": email,
    };
    json.removeWhere(
        (key, value) => value == "" || value == null || value == "null");
    return json;
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
        email
      ];
}
