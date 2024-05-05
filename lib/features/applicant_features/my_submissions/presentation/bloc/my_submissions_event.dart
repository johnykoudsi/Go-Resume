part of 'my_submissions_bloc.dart';

abstract class MySubmissionsEvent extends Equatable {

}

class GetMySubmissionsEvent extends MySubmissionsEvent{
  GetMySubmissionsEvent({required this.searchFilterProperties});

  JobSearchFilter searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}

class ChangeToLoadingApiMySubmissionsEvent extends MySubmissionsEvent {
  ChangeToLoadingApiMySubmissionsEvent(
      { this.searchFilterProperties});

  JobSearchFilter? searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}