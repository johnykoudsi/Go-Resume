part of 'experience_generation_bloc.dart';

sealed class ExperienceGenerationEvent extends Equatable {
  const ExperienceGenerationEvent();
}

final class PostExperienceGenerationEvent extends ExperienceGenerationEvent {
  PostExperienceGenerationEvent(
      {required this.company,
      required this.month,
      required this.skills,
      required this.specialization,
      required this.years});
  String specialization;
  String company;
  String skills;
  String years;
  String? month;

  @override
  List<Object> get props => [specialization, company, skills, years, month??''];

  Map<String, dynamic> toJson() => {
        "skills": skills,
        "main": specialization,
        "company": company,
        "experiance": month != null ? "$years years $month" : "$years years",
      };
}
