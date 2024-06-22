part of 'education_generation_bloc.dart';

sealed class EducationGenerationEvent extends Equatable {
  const EducationGenerationEvent();
}

final class PostEducationGenerationEvent extends EducationGenerationEvent {
  PostEducationGenerationEvent(
      {required this.school,
      required this.graduationYears,
      required this.skills,
      required this.specialization,
      required this.location});
  String specialization;
  String school;
  String skills;
  String graduationYears;
  String location;

  @override
  List<Object> get props =>
      [specialization, school, skills, location, graduationYears];

  Map<String, dynamic> toJson() => {
        "skills": skills,
        "main": specialization,
        "school": school,
        "graduating_year": graduationYears,
        "location": location,
      };
}
