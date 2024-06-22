part of 'bio_generation_bloc.dart';

sealed class BioGenerationEvent extends Equatable {
  const BioGenerationEvent();
}

final class PostBioGenerationEvent extends BioGenerationEvent {
  PostBioGenerationEvent({
    required this.education,
    required this.skills,
    required this.specialization,
  });
  String specialization;
  String education;
  String skills;

  @override
  List<Object> get props => [specialization, skills, education];

  Map<String, dynamic> toJson() => {
        "skills": skills,
        "main": specialization,
        "education": education,
      };
}
