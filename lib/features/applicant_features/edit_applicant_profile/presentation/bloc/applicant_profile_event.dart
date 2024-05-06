part of 'applicant_profile_bloc.dart';

abstract class ApplicantProfileEvent extends Equatable {
  const ApplicantProfileEvent();


}
class UpdateApplicantProfileEvent extends ApplicantProfileEvent {
  UpdateApplicantProfileEvent({
    required this.dob,
    required this.gender,
    required this.resume,
    required this.bio,
    required this.fullName,
    required this.websiteLink,
    required this.instagram,
    required this.facebook,
    required this.linkedin,
    required this.mobile,
    required this.email,
  });
  dynamic dob;
  dynamic gender;
  dynamic resume;
  dynamic bio;
  String fullName;
  dynamic websiteLink;
  dynamic instagram;
  dynamic facebook;
  dynamic linkedin;
  String mobile;
  dynamic email;

  Map<String, dynamic> toJson() {
    final json = {
      "dob": dob,
      "gender": gender,
      "resume": resume,
      "bio": bio,
      "full_name": fullName,
      "website_link": websiteLink,
      "instagram": instagram,
      "facebook": facebook,
      "linkedin": linkedin,
      "mobile": mobile,
      "email": email,
    };
    json.removeWhere((key, value) => value==null||value ==""||value.isEmpty||value=="null");
    return json;
  }


  @override
  List<Object?> get props =>
      [dob, gender, resume, bio,fullName,websiteLink,instagram,facebook,linkedin,mobile,email];
}