part of 'my_submissions_bloc.dart';

abstract class MySubmissionsEvent extends Equatable {

}

class GetMySubmissionsEvent extends MySubmissionsEvent{
  GetMySubmissionsEvent({required this.searchFilterProperties});

  SubmissionsSearchFilter searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}

class ChangeToLoadingApiMySubmissionsEvent extends MySubmissionsEvent {
  ChangeToLoadingApiMySubmissionsEvent(
      { this.searchFilterProperties});

  SubmissionsSearchFilter? searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}